module D_Flip_Flop(clock,D,clear,preset,Q);
input clock,D,clear,preset;
output reg Q = 1'b0;
specify
	(clock => Q)="";
endspecify
   initial
     begin
	Q <= 1'b0;
     end
   always@(posedge clock)
     begin
	if(clear==0)
	  Q<=0;
	else if(preset==0)
	  Q<=1;
	else
	  begin
	     Q<=D;
	  end
     end
endmodule