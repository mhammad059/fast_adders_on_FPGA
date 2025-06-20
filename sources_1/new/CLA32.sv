`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2025 05:44:08 PM
// Design Name: 
// Module Name: CLA32
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


module CLA32 #(parameter N = 32) (
    input logic Cin,
    input logic [N-1:0] operA,
    input logic [N-1:0] operB,
    output logic [N-1:0] resultOUT,
    output logic Cout
    );

    logic [2:0] carry;
    logic [1:0] Pouts;
    logic [1:0] Gouts;

    assign carry[0] = Cin;
    assign Cout = carry[2];

    genvar i;
    generate
        for(i = 0; i < 2; i = i + 1) begin
            CLA16 cla16_bit (
                .Cin(carry[i]),
                .operA(operA[(i+1)*16 - 1:i*16]),
                .operB(operB[(i+1)*16 - 1:i*16]),
                .resultOUT(resultOUT[(i+1)*16 - 1:i*16]),
                .Pout(Pouts[i]),
                .Gout(Gouts[i])
            );
        end
    endgenerate

    CLA_logic claLogic (
        .Cin,
        .p(Pouts),
        .g(Gouts),
        .Couts(carry[2:1])
    );

endmodule
