`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2018 08:35:17 PM
// Design Name: 
// Module Name: ringCounter
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


module ringCounter(
    input advance, clk,
    output [3:0] out
    );
    
    FDRE #(.INIT(1'b1)) ff_b0 (.C(clk), .R(1'b0), .CE(advance), .D(out[3]), .Q(out[0]));
    FDRE #(.INIT(1'b0)) ff_b1 (.C(clk), .R(1'b0), .CE(advance), .D(out[0]), .Q(out[1]));
    FDRE #(.INIT(1'b0)) ff_b2 (.C(clk), .R(1'b0), .CE(advance), .D(out[1]), .Q(out[2]));
    FDRE #(.INIT(1'b0)) ff_b3 (.C(clk), .R(1'b0), .CE(advance), .D(out[2]), .Q(out[3]));
endmodule
