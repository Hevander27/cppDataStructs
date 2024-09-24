classdef CList < handle
% ¶¨ÒåÁËÒ»¸ö£¨ÓÐÐòµÄ£©ÁÐ±í
% list = CList; ¶¨ÒåÒ»¸ö¿ÕµÄ¶ÓÁÐ¶ÔÏó
% list = CList(c); ¶¨Òå¶ÓÁÐ¶ÔÏó£¬²¢ÓÃc³õÊ¼»¯q£¬µ±cÎªcellÊ±£¬cµÄÔªËØÎªÕ»µÄÊý¾Ý£¬
%    ·ñÔòc±¾ÉíÎªÕ»µÄµÚÒ»¸öÊý¾Ý
%
% Ö§³Ö²Ù×÷£º
%     sz = list.size() ·µ»Ø¶ÓÁÐÄÚÔªËØ¸öÊý£¬Ò²¿ÉÓÃÀ´ÅÐ¶Ï¶ÓÁÐÊÇ·ñ·Ç¿Õ¡£
%     b = list.empty() Çå¿Õ¶ÓÁÐ
%     list.pushtofront(el) ½«ÐÂÔªËØelÑ¹ÈëÁÐ±íÍ·
%     list.pushtorear(el) ½«ÐÂÔªËØelÑ¹ÈëÁÐ±íÎ²²¿
%     el = list.popfront()  µ¯³öÁÐ±íÍ·²¿ÔªËØ£¬ÓÃ»§Ðè×Ô¼ºÈ·±£¶ÓÁÐ·Ç¿Õ
%     el = list.poprear() µ¯³öÁÐ±íÎ²²¿ÔªËØ£¬ÓÃ»§Ðè×Ô¼ºÈ·±£ÁÐ±í·Ç¿Õ
%     el = list.front() ·µ»Ø¶ÓÊ×ÔªËØ£¬ÓÃ»§Ðè×Ô¼ºÈ·±£¶ÓÁÐ·Ç¿Õ
%     el = list.back() ·µ»Ø¶ÓÎ²ÔªËØ£¬ÓÃ»§Ðè×Ô¼ºÈ·±£¶ÓÁÐ·Ç¿Õ
%     list.remove(k) É¾³ýµÚk¸öÔªËØ£¬Èç¹ûkÎª¸ºµÄ£¬Ôò´ÓÎ²²¿¿ªÊ¼Ëã 
%     list.removeall() É¾³ý¶ÓÁÐËùÓÐÔªËØ
%     list.add(el, k) ²åÈëÔªËØelµ½µÚk¸öÎ»ÖÃ£¬Èç¹ûkÎª¸ºµÄ£¬Ôò´Ó½áÎ²¿ªÊ¼Ëã
%     list.contains(el) ¼ì²éelÊÇ·ñ³öÏÖÔÚÁÐ±íÖÐ£¬Èç¹û³öÏÖ£¬·µ»ØµÚÒ»¸öÏÂ±ê
%     list.get(k) ·µ»ØÁÐ±íÖÆ¶¨Î»ÖÃµÄÔªËØ£¬Èç¹ûkÎª¸ºµÄ£¬Ôò´ÓÄ©Î²¿ªÊ¼Ëã
%     list.sublist(from, to) ·µ»ØÁÐ±íÖÐ´Ófromµ½to£¨×ó¿ªÓÒ±Õ£©Ö®¼äµÄÊÓÍ¼
%     list.content() ·µ»ØÁÐ±íµÄÊý¾Ý£¬ÒÔÒ»Î¬cellsÊý×éµÄÐÎÊ½·µ»Ø¡£
%     list.toarray() = list.content() contentµÄ±ðÃû
%
% See also CStack
%
% copyright: zhangzq@citics.com, 2010.
% url: http://zhiqiang.org/blog/tag/matlab
    properties (Access = private)
        buffer      % Ò»¸öcellÊý×é£¬±£´æÕ»µÄÊý¾Ý
        beg         % ¶ÓÁÐÆðÊ¼Î»ÖÃ
        len         % ¶ÓÁÐµÄ³¤¶È
    end
    
    properties (Access = public)
        capacity    % Õ»µÄÈÝÁ¿£¬µ±ÈÝÁ¿²»¹»Ê±£¬ÈÝÁ¿À©³äÎª2±¶¡£
    end
    
    methods
        function obj = CList(c)
            if nargin >= 1 && iscell(c)
                obj.buffer = [c(:); cell(numel(c), 1)];
                obj.beg = 1;
                obj.len = numel(c);
                obj.capacity = 2*numel(c);
            elseif nargin >= 1
                obj.buffer = cell(100, 1);
                obj.buffer{1} = c;
                obj.beg = 1;
                obj.len = 1;
                obj.capacity = 100;                
            else
                obj.buffer = cell(100, 1);
                obj.capacity = 100;
                obj.beg = 1;
                obj.len = 0;
            end
        end
        
        function s = size(obj)
            s = obj.len;
        end
        
        function b = empty(obj)  % ÅÐ¶ÏÁÐ±íÊÇ·ñÎª¿Õ
            b = (obj.len == 0);
        end
        
        function pushtorear(obj, el) % Ñ¹ÈëÐÂÔªËØµ½¶ÓÎ²
            obj.addcapacity();
            if obj.beg + obj.len  <= obj.capacity
                obj.buffer{obj.beg+obj.len} = el;
            else
                obj.buffer{obj.beg+obj.len-obj.capacity} = el;
            end
            obj.len = obj.len + 1;
        end
        
        function pushtofront(obj, el) % Ñ¹ÈëÐÂÔªËØµ½¶ÓÎ²
            obj.addcapacity();
            obj.beg = obj.beg - 1;
            if obj.beg == 0
                obj.beg = obj.capacity; 
            end
            obj.buffer{obj.beg} = el;
            obj.len = obj.len + 1;
        end
        
        function el = popfront(obj) % µ¯³ö¶ÓÊ×ÔªËØ
            el = obj.buffer(obj.beg);
            obj.beg = obj.beg + 1;
            obj.len = obj.len - 1;
            if obj.beg > obj.capacity
                obj.beg = 1;
            end
        end
        
        function el = poprear(obj) % µ¯³ö¶ÓÎ²ÔªËØ
            tmp = obj.beg + obj.len;
            if tmp > obj.capacity
                tmp = tmp - obj.capacity;
            end
            el = obj.buffer(tmp);
            obj.len = obj.len - 1;
        end
        
        function el = front(obj) % ·µ»Ø¶ÓÊ×ÔªËØ
            try
                el = obj.buffer{obj.beg};
            catch ME
                throw(ME.messenge);
            end
        end
        
        function el = back(obj) % ·µ»Ø¶ÓÎ²ÔªËØ
            try
                tmp = obj.beg + obj.len - 1;
                if tmp >= obj.capacity, tmp = tmp - obj.capacity; end;
                el = obj.buffer(tmp);
            catch ME
                throw(ME.messenge);
            end            
        end
        
        function el = top(obj) % ·µ»Ø¶ÓÎ²ÔªËØ
            try
                tmp = obj.beg + obj.len - 1;
                if tmp >= obj.capacity, tmp = tmp - obj.capacity; end;
                el = obj.buffer(tmp);
            catch ME
                throw(ME.messenge);
            end            
        end
        
        function removeall(obj) % Çå¿ÕÁÐ±í
            obj.len = 0;
            obj.beg = 1;
        end
        
        % É¾³ýµÚk¸öÔªËØ£¬k¿ÉÒÔÎª¸ºµÄ£¬±íÊ¾´ÓÎ²²¿¿ªÊ¼Ëã
        % Èç¹ûÃ»ÓÐÉè¶¨k£¬ÔòÎªÇå¿ÕÁÐ±íËùÓÐÔªËØ
        function remove(obj, k)
            if nargin == 1
                obj.len = 0;
                obj.beg = 1;
            else % k ~= 0
                id = obj.getindex(k);
                obj.buffer{id} = [];
                obj.len = obj.len - 1;
                obj.capacity = obj.capacity - 1;
                % É¾³ýÔªËØºó£¬ÐèÒªÖØÐÂµ÷ÕûbegµÄÎ»ÖÃÖµ
                if id < obj.beg
                    obj.beg = obj.beg - 1;
                end
            end
        end
        
        % ²åÈëÐÂÔªËØelµ½µÚk¸öÔªËØÖ®Ç°£¬Èç¹ûkÎª¸ºÊý£¬Ôò²åÈëµ½µ¹ÊýµÚ-k¸öÔªËØÖ®ºó
        function add(obj, el, k)
            obj.addcapacity();
            id = obj.getindex(k);
            
            if k > 0 % ²åÈëÔÚµÚid¸öÔªËØÖ®Ç°
                obj.buffer = [obj.buffer(1:id-1); el; obj.buffer(id:end)];
                if id < obj.beg
                    obj.beg = obj.beg + 1;
                end
            else % k < 0£¬²åÈëÔÚµÚid¸öÔªËØÖ®ºó
                obj.buffer = [obj.buffer(1:id); el; obj.buffer(id:end)];
                if id < obj.beg
                    obj.beg = obj.beg + 1;
                end
            end
        end
        
        % ÒÀ´ÎÏÔÊ¾¶ÓÁÐÔªËØ
        function display(obj)
            if obj.size()
                rear = obj.beg + obj.len - 1;
                if rear <= obj.capacity
                    for i = obj.beg : rear
                        disp([num2str(i - obj.beg + 1) '-th element of the stack:']);
                        disp(obj.buffer{i});
                    end
                else
                    for i = obj.beg : obj.capacity
                        disp([num2str(i - obj.beg + 1) '-th element of the stack:']);
                        disp(obj.buffer{i});
                    end     
                    for i = 1 : rear
                        disp([num2str(i + obj.capacity - obj.beg + 1) '-th element of the stack:']);
                        disp(obj.buffer{i});
                    end
                end
            else
                disp('The queue is empty');
            end
        end
        
        
        % »ñÈ¡ÁÐ±íµÄÊý¾ÝÄÚÈÝ
        function c = content(obj)
            rear = obj.beg + obj.len - 1;
            if rear <= obj.capacity
                c = obj.buffer(obj.beg:rear);                    
            else
                c = obj.buffer([obj.beg:obj.capacity 1:rear]);
            end
        end
        
        % »ñÈ¡ÁÐ±íµÄÊý¾ÝÄÚÈÝ£¬µÈÍ¬ÓÚobj.content();
        function c = toarray(obj)
            c = obj.content();
        end
    end
    
    
    
    methods (Access = private)
        
        % getindex(k) ·µ»ØµÚk¸öÔªËØÔÚbufferµÄÏÂ±êÎ»ÖÃ
        function id = getindex(obj, k)
            if k > 0
                id = obj.beg + k;
            else
                id = obj.beg + obj.len + k;
            end     
            
            if id > obj.capacity
                id = id - obj.capacity;
            end
        end
        
        % µ±bufferµÄÔªËØ¸öÊý½Ó½üÈÝÁ¿ÉÏÏÞÊ±£¬½«ÆäÈÝÁ¿À©³äÒ»±¶¡£
        % ´ËÊ±Ðý×ªÁÐ±í£¬Ê¹µÃ´Ó1¿ªÊ¼¡£Õû¸öÁÐ±íÖÁÉÙÓÐÁ½¸öÒÔÉÏ¿ÕÎ»¡£
        function addcapacity(obj)
            if obj.len >= obj.capacity - 1
                sz = obj.len;
                if obj.beg + sz - 1 <= obj.capacity
                    obj.buffer(1:sz) = obj.buffer(obj.beg:obj.beg+sz-1);                    
                else
                    obj.buffer(1:sz) = obj.buffer([obj.beg:obj.capacity, ...
                        1:sz-(obj.capacity-obj.beg+1)]);
                end
                obj.buffer(sz+1:obj.capacity*2) = cell(obj.capacity*2-sz, 1);
                obj.capacity = 2*obj.capacity;
                obj.beg = 1;
            end
        end
    end % private methos
    
    methods (Abstract)
        
    end
end