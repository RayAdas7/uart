module uart_loop_tb(
    );
    
    reg clk;
    reg rst_n;
    wire wireuart;
    reg [7:0] tx_tdata;
    uart
#(
    .CLK_FRE            (50        ),//refclk freq,MHZ
    .DATA_WIDTH         (8         ),//uart data width 
    .PARITY_ON          (1         ),//0:don't parity   1:do parity
    .PARITY_TYPE        (1         ),//0:even parity    1:odd parity
    .BAUD_RATE          (115200    ) //baud rate    
)
uart0
(
        .clk         (clk),
        .rst_n       (rst_n),
        .rx_tvalid   (),
        .rx_tdata    (),
        .tx_valid    (1),
        .tx_ready    (),
        .tx_tdata    (tx_tdata),
        .rx          (wireuart),
        .tx          (wireuart)
    );
    
    always@(posedge clk)
        tx_tdata <= $random;
        
        
    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        #103
        rst_n = 1;
    end
    
    always #10 clk = ~clk;
    

    



endmodule
