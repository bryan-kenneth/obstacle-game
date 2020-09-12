`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2018 02:38:14 PM
// Design Name: 
// Module Name: Top_Lab7
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


module Top_Lab7(
    input clkin,
    input btnC, btnR, btnU, btnD, btnL,
    input reset_sw, cheat_sw,
    output [6:0] seg,
    output [3:0] an,
    input [6:4] sw,
    output [3:0] vgaRed, vgaBlue, vgaGreen,
    output Hsync, Vsync
    );
    
    //wires
    wire [13:0] obs, f;
    wire [9:0] HQ, VQ, size;
    wire clk, digsel, o_clk, s_clk, frame, start_flash, obsticle, walls;
    
    //Given clocks
    lab7_clks not_so_slow (.clkin(clkin), .greset(sw[0]), .clk(clk), .digsel(digsel));
    
    //Flash clocks
    Toggle_clk o_flash(.clk(clk), .start(start_flash), .frame(frame), .cycles(10'd8), .clk_out(o_clk));
    Toggle_clk s_flash(.clk(clk), .start(start_flash | win), .frame(frame), .cycles(10'd16), .clk_out(s_clk));
    
    Mins_Secs timer(.clk(clk), .start(start_t & ~win & ~start_flash), .flash(win), .digsel(digsel), .frame(frame),
                    .f_clk(s_clk), .reset(reset), .an(an), .seg(seg));
    
    VGAcontroller Vcont(.clk(clk), .AR(AR), .Hsync(Hsync), .Vsync(Vsync), .HQ(HQ), .VQ(VQ), .frame(frame));
    
    //Slug
    Slug_SM ssm(.clk(clk), .btnL(btnL), .btnR(btnR), .btnU(btnU), .btnD(btnD), .btnC(btnC),
                .flash(start_flash), .frame(frame), .f_clk(s_clk),
                .HQ(HQ), .VQ(VQ), .bC(bC), .bA(bA), .slug(slug), .win(win), .reset(reset));
    
    //Vertical obsticles
    vObst_SM vObst0(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b0), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd158), .gap_in(10'd78), .start_t(start_t), .obst(obs[0]), .flash(f[0]));
    vObst_SM vObst1(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b1), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd208), .gap_in(10'd128), .obst(obs[1]), .flash(f[1]));
    vObst_SM vObst2(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b0), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd258), .gap_in(10'd178), .obst(obs[2]), .flash(f[2]));
    vObst_SM vObst3(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b1), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd308), .gap_in(10'd228), .obst(obs[3]), .flash(f[3]));
    vObst_SM vObst4(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b0), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd358), .gap_in(10'd278), .obst(obs[4]), .flash(f[4]));
    vObst_SM vObst5(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b1), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd408), .gap_in(10'd328), .obst(obs[5]), .flash(f[5]));
    vObst_SM vObst6(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b0), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd458), .gap_in(10'd378), .obst(obs[6]), .flash(f[6]));
    
    //Horizontal obsticles 
    hObst_SM hObst0(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b1), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd78), .gap_in(10'd158), .obst(obs[7]), .flash(f[7]));
    hObst_SM hObst1(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b0), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd128), .gap_in(10'd208), .obst(obs[8]), .flash(f[8]));
    hObst_SM hObst2(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b1), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd178), .gap_in(10'd258), .obst(obs[9]), .flash(f[9]));
    hObst_SM hObst3(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b0), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd228), .gap_in(10'd308), .obst(obs[10]), .flash(f[10]));
    hObst_SM hObst4(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b1), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd278), .gap_in(10'd358), .obst(obs[11]), .flash(f[11]));
    hObst_SM hObst5(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b0), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd328), .gap_in(10'd408), .obst(obs[12]), .flash(f[12]));
    hObst_SM hObst6(.clk(clk), .bC(bC), .bA(bA), .drctn(1'b1), .frame(frame), .slug(slug), .f_clk(o_clk),
             .HQ(HQ), .VQ(VQ), .size(size), .TLC(10'd378), .gap_in(10'd458), .obst(obs[13]), .flash(f[13]));
    
    assign size = {2'b00, sw[6:4], 5'b10000};
    assign start_flash = ~cheat_sw & (| f);
    assign obsticle = (| obs);
    assign brighten = (| obs[13:7]) & (| obs[6:0]);
    assign walls = (~win | s_clk) & ((HQ <= 10'd7) | (HQ >= 10'd631) | (VQ <= 10'd7) | (VQ >= 10'd471));
       
    assign vgaRed = {4{AR}} & ({4{slug}} & {4'b1000}) | ({4{obsticle}} & {4'b1000}) | ({4{brighten}} & {4'b1111});
    assign vgaBlue = {4{AR}} & {4{walls}} & {4'b1000};
    assign vgaGreen = {4{AR}} & {4{slug}} & {4{4'b1000}};
    
endmodule
