`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2025 02:35:10 PM
// Design Name: 
// Module Name: RCA32
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


module RCA32 #(parameter N = 32) (
    input logic Cin,
    input logic [N-1:0] operA,
    input logic [N-1:0] operB,
    output logic [N-1:0] resultOUT,
    output logic Cout
    );

    logic [(N/4):0] carry;
    assign carry[0] = Cin;
    assign Cout = carry[(N/4)];

    genvar i;
    generate
        for (i = 0; i < (N/4); i = i + 1) begin : gen_rca4
            RCA4 rca4_inst(
                .Cin(carry[i]),
                .operA(operA[(i+1)*4 - 1:i*4]),
                .operB(operB[(i+1)*4 - 1:i*4]),
                .resultOUT(resultOUT[(i+1)*4 - 1:i*4]),
                .Cout(carry[i+1])
            );
        end
    endgenerate

endmodule
