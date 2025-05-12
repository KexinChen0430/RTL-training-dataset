
module acl_registered_comparison(clock,left,right,enable,result);

  parameter  WIDTH = 32;
  input  clock,enable;
  input  [WIDTH+(0-1):0] left;
  input  [WIDTH+(0-1):0] right;
  output result;
  localparam  SECTION_SIZE = 4;
  localparam 
       SECTIONS = ((WIDTH%SECTION_SIZE) == 0) ? (WIDTH/SECTION_SIZE) : (1+(WIDTH/SECTION_SIZE));
  reg  [(0-1)+SECTIONS:0] comparisons;
  wire [SECTION_SIZE*SECTIONS:0] 
       temp_left = {{{(1+(SECTION_SIZE*SECTIONS))+(-WIDTH)}{1'b0}},left};
  wire [SECTION_SIZE*SECTIONS:0] 
       temp_right = {{{(1+(SECTION_SIZE*SECTIONS))+(-WIDTH)}{1'b0}},right};

  genvar i;
  
  generate
      for (i = 0; i < SECTIONS; i = i+1)
          begin : cmp
            
            always @(posedge clock)
                begin
                  if (enable) 
                    comparisons[i] <= temp_left[((i+1)*SECTION_SIZE)+(0-1):i*SECTION_SIZE] == temp_right[((i+1)*SECTION_SIZE)+(0-1):i*SECTION_SIZE];
                    
                end
          end
  endgenerate

  assign result = &comparisons;
endmodule

