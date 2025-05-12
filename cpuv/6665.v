module frame_typ_e0; 
   reg [7:0]  data  [0:61]; 
   reg        valid [0:61]; 
   reg        error [0:61]; 
   reg        bad_frame; 
`define FRAME_TYP [8*62+62+62+1:1] 
   reg `FRAME_TYP bits; 
   function `FRAME_TYP tobits;
      input dummy; 
      begin
         bits = {data[ 0],  data[ 1],  ... , data[61],
                 valid[ 0], valid[ 1], ... , valid[61],
                 error[ 0], error[ 1], ... , error[61],
                 bad_frame};
         tobits = bits; 
      end
   endfunction 
   task frombits;
      input `FRAME_TYP frame; 
      begin
         bits = frame; 
         {data[ 0],  data[ 1],  ... , data[61],
          valid[ 0], valid[ 1], ... , valid[61],
          error[ 0], error[ 1], ... , error[61],
          bad_frame} = bits;
      end
   endtask 
endmodule 