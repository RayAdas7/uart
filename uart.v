`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/19 16:26:18
// Design Name: 
// Module Name: uart
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart
#(
    parameter   CLK_FRE     = 50        ,//refclk freq,MHZ
    parameter   DATA_WIDTH  = 8         ,//uart data width 
    parameter   PARITY_ON   = 1         ,//0:don't parity   1:do parity
    parameter   PARITY_TYPE = 1         ,//0:even parity    1:odd parity
    parameter   BAUD_RATE   = 115200     //baud rate    
)
(
    input           clk         ,
    input           rst_n       ,
    //rx
    output          rx_tvalid   ,
    output [7:0]    rx_tdata    ,
    //tx
    input           tx_valid    ,
    output          tx_ready    ,
    input   [7:0]   tx_tdata    ,
    //uart 
    input           rx          ,
    output          tx  
    );
    
    
    uart_rx 
    #(
            .CLK_FRE(CLK_FRE),         //时钟频率，默认时钟频率为50MHz
            .DATA_WIDTH(DATA_WIDTH),       //有效数据位，缺省为8位
            .PARITY_ON(PARITY_ON),        //校验位，1为有校验位，0为无校验位，缺省为0
            .PARITY_TYPE(PARITY_TYPE),      //校验类型，1为奇校验，0为偶校验，缺省为偶校验
            .BAUD_RATE(BAUD_RATE)      //波特率，缺省为9600
    ) u_uart_rx
    (
        .i_clk_sys(clk),      //系统时钟
        .i_rst_n(rst_n),        //全局异步复位,低电平有效
        .i_uart_rx(rx),      //UART输入
        .o_uart_data(rx_tdata),    //UART接收数据
        .o_ld_parity(),    //校验位检验LED，高电平位为校验正确
        .o_rx_done(rx_tvalid)       //UART数据接收完成标志
    );
    
    uart_tx
    #(
        .CLK_FRE(CLK_FRE),         //时钟频率，默认时钟频率为50MHz
        .DATA_WIDTH(DATA_WIDTH),       //有效数据位，缺省为8位
        .PARITY_ON(PARITY_ON),        //校验位，1为有校验位，0为无校验位，缺省为0
        .PARITY_TYPE(PARITY_TYPE),      //校验类型，1为奇校验，0为偶校验，缺省为偶校验
        .BAUD_RATE(BAUD_RATE)      //波特率，缺省为9600
    ) u_uart_tx
    (   .i_clk_sys(clk),      //系统时钟
        .i_rst_n(rst_n),        //全局异步复位
        .i_data_tx(tx_tdata),      //传输数据输入
        .i_data_valid(tx_valid),   //传输数据有效
        .o_data_ready(tx_ready),
        .o_uart_tx(tx)       //UART输出
        );
endmodule
