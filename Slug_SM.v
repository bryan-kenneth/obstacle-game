`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2018 06:42:48 PM
// Design Name: 
// Module Name: Slug_SM
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


module Slug_SM(
    input clk, btnL, btnR, btnU, btnD, btnC,
    input flash, frame, f_clk,
    input [9:0] HQ, VQ,
    output bC, bA, slug, win, reset
    );
    
    wire [2:0] D, Q;
    wire [9:0] slug_h, slug_v;
    
    //syncing inputs to clock
    FDRE #(.INIT(1'b0)) ff_L (.C(clk), .R(1'b0), .CE(1'b1), .D(btnL), .Q(bL));
    FDRE #(.INIT(1'b0)) ff_R (.C(clk), .R(1'b0), .CE(1'b1), .D(btnR), .Q(bR));
    FDRE #(.INIT(1'b0)) ff_U (.C(clk), .R(1'b0), .CE(1'b1), .D(btnU), .Q(bU));
    FDRE #(.INIT(1'b0)) ff_D (.C(clk), .R(1'b0), .CE(1'b1), .D(btnD), .Q(bD));
    FDRE #(.INIT(1'b0)) ff_C (.C(clk), .R(1'b0), .CE(1'b1), .D(btnC), .Q(bC));
    assign bA = bL | bR | bU | bD;
       
    assign D[0] = bC | Q[0] & ~(slug_h == 10'd10 & slug_v == 10'd10);
    assign D[1] = (slug_h == 10'd10 & slug_v == 10'd10) | Q[1] & ~bC;
    FDRE #(.INIT(1'b1)) ff_s0 (.C(clk), .R(1'b0), .CE(1'b1), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) ff_s1 (.C(clk), .R(1'b0), .CE(1'b1), .D(D[1]), .Q(Q[1]));
    
    //Slug Position
    assign reset = Q[0];
    countUD10L Slug_H(.clk(clk), .up(bR & ~bL & (slug_h < 10'd615) & ~flash & ~win), .dw(bL & ~bR & (slug_h > 10'd8) & ~flash & ~win),
                      .CE(frame | reset), .LD(reset), .D(10'd10), .Q(slug_h));
    countUD10L Slug_V(.clk(clk), .up(bD & ~bU & (slug_v < 10'd455) & ~flash & ~win), .dw(bU & ~bD & (slug_v > 10'd8) & ~flash & ~win),
                      .CE(frame | reset), .LD(reset), .D(10'd10), .Q(slug_v));
    
    assign slug = (~flash | f_clk) & (HQ >= slug_h) & (HQ <= (slug_h + 10'd15)) & (VQ >= slug_v) & (VQ <= (slug_v + 10'd15));
    assign win = (slug_h >= 10'd609) & (slug_v >= 10'd449);
       
endmodule
