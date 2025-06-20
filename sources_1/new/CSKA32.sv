`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2025 06:40:17 PM
// Design Name: 
// Module Name: CSKA32
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


module CSKA32 (
    input logic Cin,
    input logic [31:0] operA,
    input logic [31:0] operB,
    output logic [31:0] resultOUT,
    output logic        Cout
);

    // BLOCKS = 8;     // 32 / 4
    // WIDTH  = 4;

    logic [8:0] carries;
    logic [7:0][3:0] partial_sum;
    logic [7:0] block_cout;
    logic [7:0] block_propagate;

    assign carries[0] = Cin;

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_8

            // 4-bit chunks
            wire [3:0] Ai = operA[4*i +: 4];
            wire [3:0] Bi = operB[4*i +: 4];

            // RCA4 blocks
            RCA4 #(.N(4)) rca_inst (
                .Cin(carries[i]),
                .operA(Ai),
                .operB(Bi),
                .resultOUT(partial_sum[i]),
                .Cout(block_cout[i])
            );

            // Block propagate: all Ai ^ Bi == 1
            assign block_propagate[i] = & (Ai ^ Bi);

            // Generate carry to next block
            assign carries[i+1] = block_propagate[i] ? carries[i] : block_cout[i];

            // Assign result
            assign resultOUT[4*i +: 4] = partial_sum[i];

        end
    endgenerate

    assign Cout = carries[8];
endmodule
