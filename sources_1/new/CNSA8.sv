`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2025 02:41:40 PM
// Design Name: 
// Module Name: CNSA8
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


module CNSA #(parameter N = 8)(
    input logic Cin,
    input logic [N-1:0] operA,
    input logic [N-1:0] operB,
    output logic [N-1:0] resultOUT,
    output logic Cout
);
    logic [N-1:0] s0, s1;
    logic [N-1:0] c0, c1;
    logic [N-1:0] carry;

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : gen_CC
            CC cc_inst (.a(operA[i]), .b(operB[i]), .s0(s0[i]), .s1(s1[i]), .c0(c0[i]), .c1(c1[i]));
        end
    endgenerate

    assign resultOUT[0] = Cin ? s1[0] : s0[0];
    assign carry[0] = Cin ? c1[0] : c0[0];

    generate
        for (i = 1; i < N; i = i + 1) begin : gen_assigns
            assign resultOUT[i] = carry[i-1] ? s1[i] : s0[i];
            assign carry[i] = carry[i-1] ? c1[i] : c0[i];
        end
    endgenerate

    assign Cout = carry[N-1];
endmodule
