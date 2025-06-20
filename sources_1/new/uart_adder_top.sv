`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2025 02:17:15 PM
// Design Name: 
// Module Name: uart_adder_top
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


module uart_adder_top(
    input logic rst,
    input logic sys_clk,
    input logic sub,

    input logic [1:0] sel_baud, // 0:4800, 1:9600, 2:19200, 3:38400
    
    input logic rx_data,
    output logic tx_data,

    output logic rx_status,
    output logic tx_status,

    output logic Cout
    );

    logic [31:0] ALUout;
    logic [31:0] operA;
    logic [31:0] operB;
    logic [63:0] operAB;

    multiByteUART_top UART_SB(
    .rst,
    .sys_clk,
    .sel_baud, // 0:4800, 1:9600, 2:19200, 3:38400
    .rx_data,
    .serial_out_TX(ALUout),
    .serial_in_RX(operAB),
    .tx_data,  
    .rx_status,
    .tx_status
    );

    // subtractor logic
    assign operA = sub ? ~operAB[63:32] : operAB[63:32];
    assign operB = operAB[31:0];

    // assign {Cout, ALUout} = (operA + operB) + sub; // using + operator
    
    // RCA32 rca32bit(.Cin(sub), .operA, .operB, .resultOUT(ALUout), .Cout); // ripple carry
    
    // CLA32 cla32bit(.Cin(sub), .operA, .operB, .resultOUT(ALUout), .Cout); // carry look-ahead
    
    // CSA_4bit6oper csa_adder(.operA(operAB[23:20]), .operB(operAB[19:16]), .operC(operAB[15:12]),
    //             .operD(operAB[11:8]), .operE(operAB[7:4]), .operF(operAB[3:0]),
    //             .result(ALUout[6:0])); assign Cout = sub;

    // CNSA cnsa_adder(.Cin(sub), .operA(operA[7:0]), .operB(operB[7:0]), .resultOUT(ALUout[7:0]), .Cout);
    
    CSKA32 cska_32bit(.Cin(sub), .operA, .operB, .resultOUT(ALUout), .Cout);

endmodule
