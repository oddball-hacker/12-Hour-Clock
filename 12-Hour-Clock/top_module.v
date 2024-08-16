module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    wire t1, t2;
    count59 seconds ( clk, ena, reset, 1'b1, ss, t1 );
    count59 minutes ( clk, ena, reset, t1, mm, t2 );
    count12 hours ( clk, ena, reset,t1 & t2, hh );
    always @ (posedge clk) begin
        if ( reset ) 
            pm <= 1'b0;
        //else if ( hh == 8'b00010001 & t1 == 1'b1 & t2 == 1'b1 ) 
          //  pm <= ~ pm;
    end

endmodule

module count_9 ( 
    input clk,
    input reset,
    input enable,
    output reg enableout,
    output reg [3:0] out );
    always @ (*) begin
        if ( out == 4'b1001 )
            enableout = 1'b1;
        else 
            enableout = 1'b0;
    end
    always @ ( posedge clk ) begin
        if ( reset )
            out <= 4'b0;
        else if ( enable ) begin
            if ( out == 4'b1001 ) 
                out <= 4'b0;
            else 
                out <= out + 4'b0001;
        end
    end
endmodule
module count_5 (
    input clk,
    input reset,
    input enable,
    input enablem,
    output reg enableout,
    output reg [3:0] out );
    always @ (*) begin
        if ( out == 4'b0101 )
            enableout = 1'b1;
        else 
            enableout = 1'b0;
    end
    always @ ( posedge clk ) begin
        if ( reset )
            out <= 4'b0;
        else if ( enable && enablem ) begin
            if ( out == 4'b0101 ) 
                out <= 4'b0;
            else 
                out <= out + 4'b0001;
        end
    end
endmodule

module count59 (
    input clk,
    input enable,
    input reset,
    input enablem,
    output [7:0] out59,
    output enableout );
    wire t3, t4, ena;          //t3 is enablem for count5
    assign ena = enable & enablem;
    count_5 paratha ( clk, reset, ena, t3, t4, out59[7:4] );
    count_9 aloo ( clk, reset, ena, t3, out59[3:0] );
    assign enableout = t3 & t4;
endmodule

module count2 ( 
    input clk,
    input enable,
    input cond,
    input reset,
    input outL,
    output reg condout,
    output reg [3:0] out );
    always @ (*) begin
        if ( (out == 4'b0010 && outL == 1'b1 ) || out == 4'b1001 )
            condout = 1'b1;
        else 
            condout = 1'b0;
    end 
    always @ ( posedge clk ) begin
        if ( reset ) 
            out <= 4'b0010;
        else if ( enable ) begin
		      if (out == 4'b1001 ) begin
                out <= 4'b0000; end
            else if ( cond == 1'b1 && out == 4'b0010 )
                out <= 1'b0001;
            
            else if ( out == 4'b0010 && cond == 1'b1 )
				    out <= 4'b0001;
            else out <= out + 1'b1;
        end
    end
endmodule

module count1 (
    input clk, 
    input reset,
    input enable,
    input cond,
    output reg condout,
    output [3:0] out );
    //assign condout = out[0];
	 always @ (*)
	 condout = out[0];
    reg outL;
    assign out = {3'b0, outL};
    always @ ( posedge clk ) begin
        if ( reset ) 
            outL <= 1'b1;
        else if ( enable ) begin
            if ( cond ) 
                outL <= ~outL;
        end
    end
endmodule

module count12 (
    input clk,
    input enable,
    input reset,
    input enablem,
    output [7:0] h );
    wire t1, t2, ena;
    wire outL;
    assign outL = h[4];
    assign ena = enable & enablem;
    count1 coconut ( clk, reset, ena, t1, t2, h[7:4] );
    count2 maggi ( clk, ena, t2, reset,outL, t1, h[3:0] );
endmodule   