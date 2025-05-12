module comma_assign;
   int n[1:2][1:3] = 
       '{ 
           '{0,1,2}, 
           '{3{4}}   
       }; 
endmodule 