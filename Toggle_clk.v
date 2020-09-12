`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2018 07:11:34 PM
// Design Name: 
// Module Name: hSec
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


module Toggle_clk(
    input clk, start, frame,
    input [9:0] cycles,
    output clk_out
    );
    
    wire [9:0] CQ;
    countUD10L timer(.clk(clk), .up(frame), .dw(1'b0), .CE(start), .LD(Creset), .D(10'd0), .Q(CQ));
    assign Creset = (CQ >= cycles);
    
    FDRE #(.INIT(1'b0)) ff(.C(clk), .R(1'b0), .CE(Creset), .D(~clk_out), .Q(clk_out));
    
endmodule
