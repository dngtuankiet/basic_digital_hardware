`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2019 09:13:00 AM
// Design Name: 
// Module Name: SPI_Master
// Project Name: SPI_Master without Chip Select Interface
// Target Devices: 
// Tool Versions: 
// Description: Serial Peripheral Interface Master sends a byte one bit at a time on MOSI line.
//              Receive incoming byte data on MISO line.
//              
//              Start transmission by pulsing i_MOSI_DV.
//              Multi-byte transmission by pulsing i_MOSI_DV and loading up i_MOSI_Byte when o_MOSI_Ready is H.
//       
//              This module generates SPI_Clk, controls MOSI and MISO line. If Chip Select (CS) is needed this
//              must be done at a higher level.
//              
//              i_Clk must be at least 2x faster than i_SPI_Clk
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SPI_Master
    #(parameter SPI_MODE = 0,
      parameter CLKS_PER_HALF_BIT = 2)
    (
    input i_Rst_n,
    input i_Clk,
    
    // Transmit (MOSI) signals
    input [7:0] i_MOSI_Byte,    // Byte to transmit on MOSI
    input       i_MOSI_DV,      // Data valid Pulse with MOSI Byte
    output reg  o_MOSI_Ready,   // Transmit Ready for next byte
    
    // Receive (MISO) signals
    output reg       o_MISO_DV, // Data valid Pulse
    output reg [7:0] o_MISO_Byte, // Byte received on MISO
    
    // SPI Interface
    output reg o_SPI_Clk,
    input      i_SPI_MISO,
    output reg o_SPI_MOSI
    );
    
    // SPI Interface (Run at SPI Clock Domain)
    wire w_CPOL; // Clk Polarity
    wire w_CPHA; // Clk Phase
    
    reg [$clog2(CLKS_PER_HALF_BIT * 2) - 1:0] r_SPI_Clk_Count;
    reg r_SPI_Clk;
    reg [4:0] r_SPI_Clk_Edges;
    reg r_Leading_Edge;
    reg r_Trailing_Edge;
    reg r_Tx_DV;
    reg [7:0] r_Tx_Byte;
    reg [2:0] r_Tx_Bit_Count;
    reg [2:0] r_Rx_Bit_Count;
    
    // CPOL = 0 => Clk idles at 0, leading edge is rising edge
    // CPOL = 1 => Clk idles at 1, leading edge is falling edge
    assign w_CPOL = (SPI_MODE == 2) | (SPI_MODE == 3);
    
    // CPHA = 0 => "Leading edge" = capture
    //             "Trailing edge" = toggle
    // CPHA = 1 => "Leading edge" = toggle
    //             "Trailing edge" = capture
    assign w_CPHA = (SPI_MODE == 1) | (SPI_MODE == 3);
    
    // Generate SPI Clk correct number of times when DV pulse comes
    always @(posedge i_Clk or negedge i_Rst_n)
    begin
        if(~i_Rst_n) begin
            o_MOSI_Ready <= 1'b0;
            r_SPI_Clk_Edges <= 0;
            r_Leading_Edge <= 1'b0;
            r_Trailing_Edge <= 1'b0;
            r_SPI_Clk <= w_CPOL; // default state of SPI Clk
            r_SPI_Clk_Count <= 0;
        end
        else begin
        
            // Default assignment
            r_Leading_Edge <= 1'b0;
            r_Trailing_Edge <= 1'b0;
            
            // Check for 1 pulse of Data Valid from Upper Layer
            if(i_MOSI_DV) begin 
                o_MOSI_Ready <= 1'b0;
                r_SPI_Clk_Edges <= 16; // # edges in 1 byte = 16
            end
            else if (r_SPI_Clk_Edges > 0) begin
                o_MOSI_Ready <= 1'b0;
                
                if(r_SPI_Clk_Count == CLKS_PER_HALF_BIT*2 - 1) begin
                    r_SPI_Clk_Edges <= r_SPI_Clk_Edges - 1;
                    r_Trailing_Edge <= 1'b1;
                    r_SPI_Clk_Count <= 0;
                    r_SPI_Clk <= ~r_SPI_Clk;
                end
                else if(r_SPI_Clk_Count == CLKS_PER_HALF_BIT - 1) begin
                    r_SPI_Clk_Edges <= r_SPI_Clk_Edges - 1;
                    r_Leading_Edge <= 1'b1;
                    r_SPI_Clk_Count <= r_SPI_Clk_Count + 1;
                    r_SPI_Clk <= ~r_SPI_Clk;
                end
                else begin
                    r_SPI_Clk_Count <= r_SPI_Clk_Count + 1;
                end
            end
            else begin
                o_MOSI_Ready <= 1'b1;
            end
        end // else: ~if(~i_Rst_n)
    end // always @
    
    
    
    // Register i_MOSI_Byte when Data Valid is pulsed
    always @(posedge i_Clk or negedge i_Rst_n) begin
        if(~i_Rst_n) begin
            r_Tx_Byte <= 8'b00;
            r_Tx_DV <= 1'b0;
        end
        else begin
            r_Tx_DV <= i_MOSI_DV; // delay 1 cycle
            if(i_MOSI_DV) begin
                r_Tx_Byte <= i_MOSI_Byte;
            end
        end // else: !if(~i_Rst_n)
    end // always @
    
    // Generate MOSI data
    always @(posedge i_Clk or negedge i_Rst_n) begin
        if(~i_Rst_n) begin
            o_SPI_MOSI <= 1'b0;
            r_Tx_Bit_Count <= 3'b111; // Send MSB first
        end
        else begin
            // If ready is H => reset bit count to default
            if(o_MOSI_Ready) begin
                r_Tx_Bit_Count <= 3'b111;
            end
            // Catch the case where we start transaction and CPHA = 0
            else if(r_Tx_DV & ~w_CPHA) begin
                o_SPI_MOSI <= r_Tx_Byte[3'b111];
                r_Tx_Bit_Count <= 3'b110;
            end
            else if((r_Leading_Edge & w_CPHA) | (r_Trailing_Edge & ~w_CPHA)) begin
                r_Tx_Bit_Count <= r_Tx_Bit_Count - 1;
                o_SPI_MOSI <= r_Tx_Byte[r_Tx_Bit_Count];
            end
        end
    end
    
    // Read in MISO data
    always @(posedge i_Clk or negedge i_Rst_n) begin
        if(~i_Rst_n) begin
            o_MISO_Byte <=   8'h00;
            o_MISO_DV <= 1'b0;
            r_Rx_Bit_Count <= 3'b111;
        end
        else begin
            // Default assignment
            o_MISO_DV <= 1'b0;
            
            if(o_MOSI_Ready) begin // Check if ready is H => reset bit count to default
                r_Rx_Bit_Count <= 3'b111; // Receive MSB first
            end
            else if((r_Leading_Edge & ~w_CPHA) | (r_Trailing_Edge & w_CPHA)) begin
                o_MISO_Byte[r_Rx_Bit_Count] <= i_SPI_MISO; // Sample data
                r_Rx_Bit_Count <= r_Rx_Bit_Count - 1;
                if(r_Rx_Bit_Count == 3'b000) begin
                    o_MISO_DV <= 1'b1;
                end
            end
        end
    end
    
    // Add clock delay to signals for alignment
    always @(posedge i_Clk or negedge i_Rst_n) begin
        if(~i_Rst_n) begin
            o_SPI_Clk <= w_CPOL;
        end
        else begin
            o_SPI_Clk <= r_SPI_Clk;
        end
    end
    
endmodule
