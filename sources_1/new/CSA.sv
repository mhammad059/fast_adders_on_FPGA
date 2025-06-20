`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2025 06:56:19 PM
// Design Name: 
// Module Name: CSA
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


module CSA #(parameter N = 4)(
    input [N-1:0] operA,
    input [N-1:0] operB,
    input [N-1:0] operC,
    output [N-1:0] C,
    output [N-1:0] P
    );

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : gen_csa_fa
            FA csa_fa_inst (.Cin(operC[i]), .A(operA[i]), .B(operB[i]), .Cout(C[i]), .sum(P[i]));
        end
    endgenerate

endmodule
