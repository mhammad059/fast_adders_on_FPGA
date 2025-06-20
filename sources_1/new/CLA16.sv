`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2025 06:13:40 PM
// Design Name: 
// Module Name: CLA16
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


module CLA16(
    input logic Cin,
    input logic [15:0] operA,
    input logic [15:0] operB,
    output logic [15:0] resultOUT,
    output logic Cout,
    output logic Pout,
    output logic Gout
    );

    logic [4:0] carry;
    logic [3:0] Pouts;
    logic [3:0] Gouts;

    assign carry[0] = Cin;
    assign Cout = carry[4];

    genvar i;
    generate
        for(i = 0; i < 4; i = i + 1) begin
            CLA4 cla4_bit (
                .Cin(carry[i]),
                .operA(operA[(i+1)*4 - 1:i*4]),
                .operB(operB[(i+1)*4 - 1:i*4]),
                .resultOUT(resultOUT[(i+1)*4 - 1:i*4]),
                .Pout(Pouts[i]),
                .Gout(Gouts[i])
            );
        end
    endgenerate

    CLA_logic claLogic (
        .Cin,
        .p(Pouts),
        .g(Gouts),
        .Couts(carry[4:1]),
        .Pout,
        .Gout
    );
endmodule
