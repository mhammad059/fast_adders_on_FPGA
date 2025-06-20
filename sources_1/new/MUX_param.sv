`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2025 02:33:17 PM
// Design Name: 
// Module Name: MUX_param
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


module MUX_param #(parameter N = 4) (
    input logic [N-1:0] sel0,
    input logic [N-1:0] sel1,
    input logic sel,
    output logic [N-1:0] mux_out
    );

    assign mux_out = sel ? sel1 : sel0;

endmodule
