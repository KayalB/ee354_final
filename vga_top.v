`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:18:00 12/14/2017 
// Design Name: 
// Module Name:    vga_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
// Date: 04/04/2020
// Author: Yue (Julien) Niu
// Description: Port from NEXYS3 to NEXYS4
//////////////////////////////////////////////////////////////////////////////////
module vga_top(
	input ClkPort,
	input BtnC,
	input BtnU,
	input BtnR,
	input BtnL,
	input BtnD,
	//VGA signal
	output hSync, vSync,
	output [3:0] vgaR, vgaG, vgaB,
	
	
	output MemOE, MemWR, RamCS, QuadSpiFlashCS
	);
	wire Reset;
	assign Reset=BtnC;
	wire[9:0] hc, vc;
	wire[15:0] score;
	wire up,down,left,right;
	wire [11:0] rgb;
	wire rst;
	
	
	reg [27:0]	DIV_CLK;
	always @ (posedge ClkPort, posedge Reset)  
	begin : CLOCK_DIVIDER
      if (Reset)
			DIV_CLK <= 0;
	  else
			DIV_CLK <= DIV_CLK + 1'b1;
	end
	wire move_clk;
	assign move_clk=DIV_CLK[19]; //slower clock to drive the movement of objects on the vga screen
	wire [11:0] background;
	display_controller dc(.clk(ClkPort), .hSync(hSync), .vSync(vSync), .hCount(hc), .vCount(vc));
	wire level_1_begin, init_1, pit_opening_1, pit_opened_1, pit_opening_2, pit_opened_2, spikes, spikes_opened, done;
	wire [9:0] xpos, ypos;
	// Will the x_pos and y_pos not work because they are 
	level_sm lsm(.clk(move_clk), .reset(BtnC), .x_pos(x_pos), .y_pos(y_pos), .level_1_begin(level_1_begin), .init_1(init_1), .pit_opening_1(pit_opening_1), .pit_opened_1(pit_opened_1), .pit_opening_2(pit_opening_2), .pit_opened_2(pit_opened_2), .spikes(spikes), .spikes_opened(spikes_opened), .death(death));
	block_controller sc(.clk(move_clk),  .rst(BtnC), .up(BtnU), .down(BtnD),.left(BtnL),.right(BtnR),.hCount(hc), .vCount(vc), .rgb(rgb), .background(background));
	


	
	assign vgaR = rgb[11 : 8];
	assign vgaG = rgb[7  : 4];
	assign vgaB = rgb[3  : 0];
	
	// disable mamory ports
	assign {MemOE, MemWR, RamCS, QuadSpiFlashCS} = 4'b1111;
	
// SSD (Seven Segment Display)
	// reg [3:0]	SSD;
	// wire [3:0]	SSD3, SSD2, SSD1, SSD0;
	
	//to show how we can interface our "game" module with the SSD's, we output the 12-bit rgb background value to the SSD's
	// assign SSD3 = 4'b0000;
	// assign SSD2 = background[11:8];
	// assign SSD1 = background[7:4];
	// assign SSD0 = background[3:0];


endmodule
