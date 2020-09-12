`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2018 10:54:01 AM
// Design Name: 
// Module Name: countUD3L
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


module countUD3L(
    input clk, up, dw, LD, CE,
    input [2:0] D,
    output [2:0] Q,
    output UTC, DTC
    );
    
    wire [2:0] next;
    wire [2:0] ff_in;
    
    assign next[0] = (~up & dw & ~Q[0]) | (up & ~dw & ~Q[0]) | (~up & ~dw & Q[0]) | (up & dw & Q[0]);
    assign next[1] = (~up & ~dw & Q[1]) | (up & Q[1] & ~Q[0]) | (dw & Q[1] & Q[0])
                     | (~up & dw & ~Q[1] & ~Q[0]) | (up & ~dw & ~Q[1] & Q[0]);
    assign next[2] = (~up & dw & ~Q[2] & ~Q[1] & ~Q[0]) | (up & ~dw & ~Q[2] & Q[1] & Q[0])
                     | (~up & ~dw & Q[2]) | (Q[2] & Q[1] & ~Q[0]) | (up & Q[2] & ~Q[0])
                     | (dw & Q[2] & Q[0]) | (Q[2] & ~Q[1] & Q[0]);
    
    assign ff_in = ({3{~LD}} & next) | ({3{LD}} & D); 
       
    FDRE #(.INIT(1'b0)) ff_b0 (.C(clk), .R(1'b0), .CE(CE), .D(ff_in[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) ff_b1 (.C(clk), .R(1'b0), .CE(CE), .D(ff_in[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) ff_b2 (.C(clk), .R(1'b0), .CE(CE), .D(ff_in[2]), .Q(Q[2]));
    
    assign UTC = (Q[2] & Q[1] & Q[0]);
    assign DTC = (~Q[2] & ~Q[1] & ~Q[0]);
endmodule
