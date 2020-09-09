classdef RSPathElem
    enumeration
        RS_NOP, RS_LEFT, RS_STRAIGHT, RS_RIGHT      
    end
    properties (Constant)
        Type = [   
            RSPathElem.RS_LEFT, RSPathElem.RS_RIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_NOP, RSPathElem.RS_NOP ;        %1
            RSPathElem.RS_RIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_RIGHT, RSPathElem.RS_NOP, RSPathElem.RS_NOP ;       %2
            RSPathElem.RS_LEFT, RSPathElem.RS_RIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_RIGHT, RSPathElem.RS_NOP ;      %3
            RSPathElem.RS_RIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_RIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_NOP ;      %4
            RSPathElem.RS_LEFT, RSPathElem.RS_RIGHT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_NOP ;   %5
            RSPathElem.RS_RIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_RIGHT, RSPathElem.RS_NOP ;  %6
            RSPathElem.RS_LEFT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_RIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_NOP ;   %7
            RSPathElem.RS_RIGHT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_RIGHT, RSPathElem.RS_NOP ;  %8
            RSPathElem.RS_LEFT, RSPathElem.RS_RIGHT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_RIGHT, RSPathElem.RS_NOP ;  %9
            RSPathElem.RS_RIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_NOP ;   %10
            RSPathElem.RS_RIGHT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_RIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_NOP ;  %11
            RSPathElem.RS_LEFT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_RIGHT, RSPathElem.RS_NOP ;   %12
            RSPathElem.RS_LEFT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_RIGHT, RSPathElem.RS_NOP, RSPathElem.RS_NOP ;    %13
            RSPathElem.RS_RIGHT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_NOP, RSPathElem.RS_NOP ;    %14
            RSPathElem.RS_LEFT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_NOP, RSPathElem.RS_NOP ;     %15
            RSPathElem.RS_RIGHT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_RIGHT, RSPathElem.RS_NOP, RSPathElem.RS_NOP ;   %16
            RSPathElem.RS_LEFT, RSPathElem.RS_RIGHT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_RIGHT ; %17
            RSPathElem.RS_RIGHT, RSPathElem.RS_LEFT, RSPathElem.RS_STRAIGHT, RSPathElem.RS_RIGHT, RSPathElem.RS_LEFT   %18
            ];
    end
end














