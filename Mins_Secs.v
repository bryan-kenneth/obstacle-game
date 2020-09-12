`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2018 12:01:36 PM
// Design Name: 
// Module Name: Mins_Secs
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


module Mins_Secs(
    input clk, start, flash, digsel, frame, f_clk, reset,
    output [3:0] an,
    output [6:0] seg
    );
    
    wire [11:0] disp;
    wire [9:0] s_out;
    wire [3:0] mr_out, ml_out, sr_out, sl_out;
    
    //s_reset is high once per second
    assign s_reset = reset | (s_out == 10'd60);
    countUD10L frame_to_secs(.clk(clk), .up(start), .dw(1'b0), .CE(frame | s_reset), .LD(s_reset), .D(10'd0), .Q(s_out));
    
    //seconds
    assign sr_reset = reset | (sr_out == 5'd10);
    countUD5L secs_r(.clk(clk), .up(1'b1), .dw(1'b0), .CE(s_reset | sr_reset), .LD(sr_reset), .D(5'd0), .Q(sr_out));
    assign sl_reset = reset | (sl_out == 5'd6);
    countUD5L secs_l(.clk(clk), .up(1'b1), .dw(1'b0), .CE(sr_reset | sl_reset), .LD(sl_reset), .D(5'd0), .Q(sl_out));
    
    //minutes
    assign mr_reset = reset | (mr_out == 5'd10);
    countUD5L mins_r(.clk(clk), .up(1'b1), .dw(1'b0), .CE(sl_reset | mr_reset), .LD(mr_reset), .D(5'd0), .Q(mr_out));
    assign ml_reset = reset | (ml_out == 5'd6);
    countUD5L mins_l(.clk(clk), .up(1'b1), .dw(1'b0), .CE(mr_reset | ml_reset), .LD(ml_reset), .D(5'd0), .Q(ml_out));
    
    assign disp = {ml_out[3:0], mr_out[3:0], sl_out[3:0], sr_out[3:0]};
    
    wire [3:0] toSel, toHex;
    ringCounter ring(.advance(digsel), .clk(clk), .out(toSel));
    selector sel(.in(disp), .sel(toSel), .H(toHex));
    hex7seg display(.n(toHex), .e(1'b1), .seg(seg));
    
    assign an[0] = ~(toSel[0] & (~flash | f_clk));
    assign an[1] = ~(toSel[1] & (~flash | f_clk));
    assign an[2] = ~(toSel[2] & (~flash | f_clk));
    assign an[3] = ~(toSel[3] & (~flash | f_clk));
    
endmodule
