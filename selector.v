`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2018 02:58:36 PM
// Design Name: 
// Module Name: m4_le
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


module selector(
    input [15:0] in,
    input [3:0] sel,
    output [3:0] H
    );
    
    assign H = ({4{sel[0]}} & in[3:0]) | ({4{sel[1]}} & in[7:4]) |
               ({4{sel[2]}} & in[11:8]) | ({4{sel[3]}} & in[15:12]);
    
endmodule
