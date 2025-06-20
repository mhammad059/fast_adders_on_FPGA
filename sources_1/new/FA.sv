`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2025 02:40:13 PM
// Design Name: 
// Module Name: FA
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


module FA(
    input logic Cin,
    input logic A,
    input logic B,
    output logic sum,
    output logic Cout,
    output logic G,
    output logic P
    );

    assign G = A&B;
    assign P = A^B;

    assign Cout = G|(Cin&(P));
    assign sum = P^Cin;

endmodule
