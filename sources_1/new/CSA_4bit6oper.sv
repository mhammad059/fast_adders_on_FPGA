`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2025 07:17:56 PM
// Design Name: 
// Module Name: CSA_4bit6oper
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


module CSA_4bit6oper(
    input logic [3:0] operA,
    input logic [3:0] operB,
    input logic [3:0] operC,
    input logic [3:0] operD,
    input logic [3:0] operE,
    input logic [3:0] operF,
    output logic [6:0] result
    ); 

    logic [3:0] C1_a;
    logic [3:0] P1_a;    
    logic [3:0] C1_b;
    logic [3:0] P1_b;

    logic [4:0] C2;
    logic [4:0] P2;

    logic [5:0] C3;
    logic [5:0] P3;

    CSA #(.N(4)) csa_stage1a (
        .operA(operA), 
        .operB(operB), 
        .operC(operC), 
        .C(C1_a), 
        .P(P1_a)
        );

    CSA #(.N(4)) csa_stage1b (
        .operA(operD), 
        .operB(operE), 
        .operC(operF), 
        .C(C1_b), 
        .P(P1_b)
        );

    CSA #(.N(5)) csa_stage2 (
        .operA({C1_a, 1'b0}), 
        .operB({1'b0, P1_a}), 
        .operC({C1_b, 1'b0}), 
        .C(C2), .P(P2)
        );

    CSA #(.N(6)) csa_stage3 (
        .operA({C2, 1'b0}), 
        .operB({{2{1'b0}}, P1_b}), 
        .operC({1'b0, P2}), 
        .C(C3), 
        .P(P3)
        );

    RCA4 #(.N(7)) rca_6bit (    
        .Cin(1'b0),
        .operA({1'b0, P3}),
        .operB({C3, 1'b0}),
        .resultOUT(result)
        );

endmodule
