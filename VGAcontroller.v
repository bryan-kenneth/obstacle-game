`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2018 01:45:20 PM
// Design Name: 
// Module Name: VGAcontroller
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


module VGAcontroller(
    input clk,
    output Hsync, Vsync, AR, frame,
    output [9:0] HQ, VQ
    );
    
    //Column Counter
    assign Hreset = (HQ >= 10'd799);
    countUD10L H_count(.clk(clk), .up(1'b1), .dw(1'b0), .CE(1'b1), .LD(Hreset), .D(10'd0), .Q(HQ));
    assign Hsync = (HQ <= 10'd654) | (HQ >= 10'd751);
    
    //Row Counter
    assign Vreset = (VQ >= 10'd524);
    countUD10L V_count(.clk(clk), .up(Hreset), .dw(1'b0), .CE(1'b1), .LD(Vreset), .D(10'd0), .Q(VQ));
    assign Vsync = (VQ <= 10'd488) | (VQ >= 10'd491);
    
    //Active Region
    assign AR = (HQ <= 10'd639) & (VQ <= 10'd479);
    
    //High once per frame
    assign frame = (HQ == 10'd660) & (VQ == 10'd490);
    
endmodule
