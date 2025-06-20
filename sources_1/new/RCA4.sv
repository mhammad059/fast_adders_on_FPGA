`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2025 02:38:09 PM
// Design Name: 
// Module Name: RCA4
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


module RCA4 #(parameter N = 4) (
    input logic Cin,
    input logic [N-1:0] operA,
    input logic [N-1:0] operB,
    output logic [N-1:0] resultOUT,
    output logic Cout
    );

    logic [N:0] Couts;
    assign Couts[0] = Cin;
    assign Cout = Couts[N];
    
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : gen_fa
            FA fa_inst (
                .A(operA[i]),
                .B(operB[i]),
                .Cin(Couts[i]),
                .sum(resultOUT[i]),
                .Cout(Couts[i+1])
            );
        end
    endgenerate

endmodule
