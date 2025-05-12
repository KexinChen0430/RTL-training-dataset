
module acl_registered_comparison(clock,left,right,enable,result);

  parameter  WIDTH = 32;
  input  clock,enable;
  input  [(0-1)+WIDTH:0] left;
  input  [(0-1)+WIDTH:0] right;
  output result;
  localparam  SECTION_SIZE = 4;
  localparam 
       SECTIONS = ((WIDTH%SECTION_SIZE) == 0) ? ((1/SECTION_SIZE)*WIDTH) : (((1/SECTION_SIZE)*WIDTH)+1);
  reg  [SECTIONS-1:0] comparisons;
  wire [SECTIONS*SECTION_SIZE:0] 
       temp_left = {{{(SECTIONS*SECTION_SIZE)+(1+(0-WIDTH))}{1'b0}},left};
  wire [SECTIONS*SECTION_SIZE:0] 
       temp_right = {{{(SECTIONS*SECTION_SIZE)+(1+(0-WIDTH))}{1'b0}},right};

  genvar i;
  
  generate
      for (i = 0; i < SECTIONS; i = i+1)
          begin : cmp
            
            always @(posedge clock)
                begin
                  if (enable) 
                    comparisons[i] <= temp_left[(SECTION_SIZE*(i+1))+(0-1):SECTION_SIZE*i] == temp_right[(SECTION_SIZE*(i+1))+(0-1):SECTION_SIZE*i];
                    
                end
          end
  endgenerate

  assign result = &comparisons;
endmodule

