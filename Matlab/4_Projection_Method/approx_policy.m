function next_a = approx_policy(coef, eval)
% Function approx_policy
%  [next_asset] = approx_policy(coef, eval)
%
% �ړI:
% ����֐��𑽍����ߎ�.
%
% ����:
% coef: �������̌W��theta
% eval: �I�_(collocation)
%
% �߂�l:
% next_a: 2���ɂ����鎑�Y����
%
% �O���[�o���ϐ�: dim_app nw

global dim_app nw

XX = zeros(nw, dim_app+1);

for i = 0:dim_app
    XX(:,i+1) = eval.^i;
end

next_a = XX*coef';

return;
