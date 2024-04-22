`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:15:38 12/14/2017 
// Design Name: 
// Module Name:    vgaBitChange 
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
module vga_bitchange(
	input clk,
	input bright,
	input up,down,left,right,
	input [9:0] hCount, vCount,
	output reg [11:0] rgb,
	output reg [15:0] score
   );
	
	parameter BLACK = 12'b0000_0000_0000;
	parameter WHITE = 12'b1110_1010_0111; //used
	parameter RED   = 12'b1110_1000_0011; //used
	parameter GREEN = 12'b0000_1111_0000;
	//parameter BLUE = 12'b0000_0000_1111;

	wire whiteZone;
	wire black_char;
	reg reset;
	reg[9:0] black_char_y;
	reg[49:0] black_char_speed; 
	reg[9:0] black_char_x;
    reg[13:0] clock_counter;
    wire jumping;

    // store as twos complement
    reg signed [4:0] y_speed;

	initial begin
		black_char_y = 10'd320;
		score = 15'd0;
		reset = 1'b0;
		black_char_x= 10'd340;
	end
	
	
	always@ (*) // paint a white box on a red background
    	if (~bright)
		rgb = GREEN; // force black if not bright
	 else if (black_char == 1)
		rgb = BLACK;
	 else if (whiteZone == 1)
		rgb = WHITE; // white box
	 else
		rgb = RED; // background color


	always@(posedge clk, posedge reset) 
		begin
			if(reset)
			begin 
                clock_counter <= 14'd0;
                y_speed <= 5'b0; // Reset y_speed

				//rough values for center of screen
			end
			else if (clk) begin
                clock_counter <= clock_counter+1;
				if(right) begin
					black_char_x<=black_char_x+10'd4; //change the amount you increment to make the speed faster 
				end
				else if(left) begin
					black_char_x<=black_char_x-10'd4;
				end
				if(up && jumping==0) begin
					black_char_y<=black_char_y+5'b01111;
                    y_speed <= 5'b01111;
                    jumping <= 1;
				end
				else begin

                    if(clock_counter % 25 == 0) begin
                        jumping <= 0;
                    end
                    
                    if(y_speed != 5'b10000 && clock_counter == 50) begin
                        y_speed <= y_speed - 1;
                    end

                    
                    black_char_y <= black_char_y + y_speed;

				end



            end
		end


	
	assign whiteZone = ((hCount >= 10'd250) && (hCount <= 10'd700)) && ((vCount >= 10'd200) && (vCount <= 10'd350)) ? 1 : 0;

	assign black_char = ((hCount >= black_char_x) && (hCount < black_char_x+10'd40)) &&
				   ((vCount >= black_char_y-10'd10) && (vCount <= black_char_y + 10'd30)) ? 1 : 0;
	
endmodule