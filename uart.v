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
            .CLK_FRE(CLK_FRE),         //ʱ��Ƶ�ʣ�Ĭ��ʱ��Ƶ��Ϊ50MHz
            .DATA_WIDTH(DATA_WIDTH),       //��Ч����λ��ȱʡΪ8λ
            .PARITY_ON(PARITY_ON),        //У��λ��1Ϊ��У��λ��0Ϊ��У��λ��ȱʡΪ0
            .PARITY_TYPE(PARITY_TYPE),      //У�����ͣ�1Ϊ��У�飬0ΪżУ�飬ȱʡΪżУ��
            .BAUD_RATE(BAUD_RATE)      //�����ʣ�ȱʡΪ9600
    ) u_uart_rx
    (
        .i_clk_sys(clk),      //ϵͳʱ��
        .i_rst_n(rst_n),        //ȫ���첽��λ,�͵�ƽ��Ч
        .i_uart_rx(rx),      //UART����
        .o_uart_data(rx_tdata),    //UART��������
        .o_ld_parity(),    //У��λ����LED���ߵ�ƽλΪУ����ȷ
        .o_rx_done(rx_tvalid)       //UART���ݽ�����ɱ�־
    );
    
    uart_tx
    #(
        .CLK_FRE(CLK_FRE),         //ʱ��Ƶ�ʣ�Ĭ��ʱ��Ƶ��Ϊ50MHz
        .DATA_WIDTH(DATA_WIDTH),       //��Ч����λ��ȱʡΪ8λ
        .PARITY_ON(PARITY_ON),        //У��λ��1Ϊ��У��λ��0Ϊ��У��λ��ȱʡΪ0
        .PARITY_TYPE(PARITY_TYPE),      //У�����ͣ�1Ϊ��У�飬0ΪżУ�飬ȱʡΪżУ��
        .BAUD_RATE(BAUD_RATE)      //�����ʣ�ȱʡΪ9600
    ) u_uart_tx
    (   .i_clk_sys(clk),      //ϵͳʱ��
        .i_rst_n(rst_n),        //ȫ���첽��λ
        .i_data_tx(tx_tdata),      //������������
        .i_data_valid(tx_valid),   //����������Ч
        .o_data_ready(tx_ready),
        .o_uart_tx(tx)       //UART���
        );
endmodule
