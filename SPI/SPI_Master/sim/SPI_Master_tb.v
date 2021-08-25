module SPI_Master_tb();
    parameter SPI_MODE = 0;
    parameter CLKS_PER_HALF_BIT = 2; //6.25MHz, 25/6.25 = 4, 4/2 = 2
    parameter MAIN_CLK_DELAY = 2; // 25MHz
    
    reg RST_N = 1'b0;
    wire SPI_CLK;
    reg CLK;
    wire SPI_MOSI;
    
    //Master Specific
    reg [7:0] MASTER_MOSI_BYTE = 0;
    reg MASTER_MOSI_DV = 1'b0;
    wire MASTER_MOSI_READY;
    wire MASTER_MISO_DV;
    wire [7:0] MASTER_MISO_BYTE;
    
    //Clock Generator
    always #(MAIN_CLK_DELAY) CLK = ~CLK;
    
    //Instantiate UUT
    
    SPI_Master
    #(.SPI_MODE(SPI_MODE),
      .CLKS_PER_HALF_BIT(CLKS_PER_HALF_BIT)) SPI_Master_UUT
     (
     // Control/Data Signals,
     .i_Rst_n(RST_N),
     .i_Clk(CLK),
     
     // MOSI Signals
     .i_MOSI_Byte(MASTER_MOSI_BYTE),
     .i_MOSI_DV(MASTER_MOSI_DV),
     .o_MOSI_Ready(MASTER_MOSI_READY),
     
     // MISO Signals
     .o_MISO_DV(MASTER_MISO_DV),
     .o_MISO_Byte(MASTER_MISO_BYTE),
     
     // SPI Interface
     .o_SPI_Clk(SPI_CLK),
     .i_SPI_MISO(SPI_MOSI), // Receive what is Transmitted
     .o_SPI_MOSI(SPI_MOSI)
     );
    
    // Send a single byte from master
    task SendSingleByte(input [7:0] data);
        begin
            @(posedge CLK);
            MASTER_MOSI_BYTE <= data;
            MASTER_MOSI_DV <= 1'b1;
            @(posedge CLK);
            MASTER_MOSI_DV <= 1'b0;
            @(posedge MASTER_MOSI_READY);
        end
    endtask
    
    initial begin
        CLK = 1'b0;
        repeat(10) @(posedge CLK);
        RST_N = 1'b0;
        repeat(10) @(posedge CLK);
        RST_N = 1'b1;
        
        // Test single byte
        SendSingleByte(8'h75);
        $display("Send out 0x75, Received 0x%X", MASTER_MISO_BYTE);
        
        SendSingleByte(8'h39);
        $display("Send out 0x39, Received 0x%X", MASTER_MISO_BYTE);
        repeat(10) @(posedge CLK);
        $finish;
    end
    
    
endmodule