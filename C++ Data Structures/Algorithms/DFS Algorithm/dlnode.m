classdef dlnode < handle


% dlnode — Construct a node and assign the value passed as an input to the Data property
% insertAfter — Insert this node after the specified node
% insertBefore — Insert this node before the specified node
% removeNode — Remove this node from the list and reconnect the remaining nodes
% clearList — Remove large lists efficiently
% delete — Private method called by MATLAB when deleting the list.


    properties
        Data
    end

    properties (SetAccess = private)
        Next = dlnode.empty
        Prev = dlnode.empty
    end

    methods

        function node = dlnode(Data)
            if (nargin > 0)
                node.Data = Data;
            end
        end 

        function insertAfter(newNode, nodeBefore)
            removeNode(newNode);
            newNode.Next = nodeBefore.Next;
            newNode.Prev = nodeBefore;
            if ~isempty(nodeBefore.Next)
                nodeBefore.Next.Prev = newNode;
            end
            nodeBefore.Next = newNode;
        end

        function removeNode(node)
            if ~isscalar(node)
                error('Nodes must be scalar')
            end
            prevNode = node.Prev;
            nextNode = node.Next;
            if ~isempty(prevNode)
                prevNode.Next = nextNode;
            end
            if ~isempty(nextNode)
                nextNode.Prev = prevNode;
            end
            node.Next = dlnode.empty;
            node.Prev = dlnode.empty;
        end

        function clearList(node)
            prev = node.Prev;
            next = node.Next;
            removeNode(node);
            while ~isempty(next)
                node = next;
                next = node.Next;
                remove(node);
            end
            while ~isempty(prev)
                node = prev;
                prev = node.Prev;
                remove(node)
            end
        end 

        methods (Access = private)
            function delete(node)
                clearList(node)
            end
        

    end
end
