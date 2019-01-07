function resid = resid_projection(coef)
% Function resid_projection
%  [residual] = resid_projection(coef)
%
% �ړI:
% �I�_(collocation)�Ɋ�Â��āA�I�C���[�������̎c����Ԃ��֐�.
%
% ����:
% �������̌W��theta: 1 x 2
%
% �߂�l:
% residual: nw x 1
%
% �O���[�o���ϐ�: w, beta, gamma, rent

global grid_w beta gamma rent

% �W��theta���g���Đ���֐����v�Z
a = approx_policy(coef, grid_w);

% �ew�ɂ�����1���̏�������v�Z
c1 = grid_w - a;

[r,c] = size(c1);
ng    = max(r,c);

% 1���ɂ�������E���p
mu1 = zeros(ng,1);
for i = 1:ng
    if c1(i) > 0.0
        mu1(i) = mu_CRRA(c1(i), gamma);
    else
        % ������l�̏ꍇ�A�y�i���e�B��^���Ă��̒l���I�΂�Ȃ��悤�ɂ���
        mu1(i) = 10000.0;
    end
end

% 2���̏����
c2 = (1.0+rent).*a;

% 2���ɂ�������E���p
mu2 = zeros(ng,1);
for i = 1:ng
    if c2(i) > 0.0
        mu2(i) = mu_CRRA(c2(i), gamma);
    else
        mu2(i) = 10000.0;
    end
end

% �c��
resid = beta*(1.0+rent)*(mu2./mu1) - 1.0;

return;

