`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2018 01:50:42 PM
// Design Name: 
// Module Name: countUD5L
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


module countUD5L(
    input clk, up, dw, LD, CE,
    input [4:0] D,
    output [4:0] Q,
    output UTC, DTC
    );
    
    wire zero, ones;
    
    countUD3L ls3b(.clk(clk), .up(up), .dw(dw), .LD(LD), .CE(CE), .D(D[2:0]), .Q(Q[2:0]), .UTC(ones), .DTC(zero));
    
    wire [1:0] next;
    wire [1:0] ff_in;
    
    assign next[0] = (~up & ~dw & Q[3]) | (up & Q[3] & ~ones) | (dw & Q[3] & ones)
                        | (~up & dw & ~Q[3] & zero) | (up & ~dw & ~Q[3] & ones)
                        | (~up & ~Q[4] & Q[3] & ~zero) | (Q[3] & dw & ~zero);
    assign next[1] = (~up & dw & ~Q[4] & ~Q[3] & zero) | (up & ~dw & ~Q[4] & Q[3] & ones)
                        | (~up & ~dw & Q[4]) | (Q[4] & Q[3] & zero) | (up & Q[4] & zero)
                        | (dw & Q[4] & ones) | (Q[4] & ~Q[3] & ones) | (Q[4] & ~Q[3] & ~dw)
                        | (Q[4] & Q[3] & ~ones) | (Q[4] & ~Q[3] & ~zero);
    
    assign ff_in = ({2{~LD}} & next) | ({2{LD}} & D[4:3]);                    
    
    FDRE #(.INIT(1'b0)) ff_b3 (.C(clk), .R(1'b0), .CE(CE), .D(ff_in[0]), .Q(Q[3]));
    FDRE #(.INIT(1'b0)) ff_b4 (.C(clk), .R(1'b0), .CE(CE), .D(ff_in[1]), .Q(Q[4]));
    
    assign UTC = Q[4] & Q[3] & ones;
    assign DTC = ~Q[4] & ~Q[3] & zero;
    
endmodule
