`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2025 02:28:13 PM
// Design Name: 
// Module Name: CC
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


module CC(
    input logic a,
    input logic b,
    output logic s0,
    output logic s1,
    output logic c0,
    output logic c1
    );

    assign s0 = a ^ b;
    assign s1 = a ^ b ^ 1;     // sum when Cin = 1
    assign c0 = a & b;         // carry when Cin = 0
    assign c1 = (a & b) | (a ^ b);  // carry when Cin = 1

endmodule
