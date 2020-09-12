`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2018 03:22:34 PM
// Design Name: 
// Module Name: countUD10L
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


module countUD10L(
    input clk, up, dw, CE, LD,
    input [9:0] D,
    output [9:0] Q
    );
    
    wire UTC, DTC;
    countUD5L LSB(.clk(clk), .up(up), .dw(dw), .LD(LD), .CE(CE), .D(D[4:0]), .Q(Q[4:0]), .UTC(UTC), .DTC(DTC));
    countUD5L MSB(.clk(clk), .up(up & UTC), .dw(dw & DTC), .LD(LD), .CE(CE), .D(D[9:5]), .Q(Q[9:5]));
    
endmodule
