module elevator_car_driver(current_floor,direction,destination,clock); 
    elevator_car_driver cd0(floor,course,target,tbclock); 
    initial 
       tbclock = 1'b0; 
    always 
        #1 tbclock = ~tbclock; 
    initial begin 
        $monitor("At time",$time," target: %h floor: %h",target,floor); 
        #200 $finish; 
    end
    initial begin 
          #5 course <= 1; 
          #1 target <= 5; 
          #15 course <= 0; 
          #1  target <= 3; 
          #15 course <= 1; 
          #1 target <= 10; 
    end
endmodule 