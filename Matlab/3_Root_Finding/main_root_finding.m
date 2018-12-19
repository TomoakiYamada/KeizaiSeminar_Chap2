%% ���C���t�@�C��:
% ����`�֐��̍������߂�֐��𗘗p����2���ԃ��f��������.

clear;
clear global;
close all;
format short;

% �O���[�o���ϐ��Fresid_two_period.m�ƕϐ������L
global w beta gamma rent

%% *** �J���u���[�V���� ***
beta  = 0.985.^30;     % �������q
gamma = 2.0;           % ���ΓI�댯���x
rent  = 1.025.^30-1.0; % �����q��
%======================================

% *** �p�����[�^ ***
nw    =  10;   % �����O���b�h�̐�
w_max = 1.0;   % �����O���b�h�̍ő�l
w_min = 0.1;   % �����O���b�h�̍ŏ��l
na    =  40;   % ���~�O���b�h�̐�
a_max = 1.0;   % ���~�O���b�h�̍ő�l
a_min = 0.025; % ���~�O���b�h�̍ŏ��l
%==================================

%% �����A���S���Y�����g����2���ԃ��f��������

tic % �v�Z���Ԃ��J�E���g�J�n

disp(' ');
disp('-+-+-+- Solve two period model using nonlinear equation solver -+-+-+-');

% �O���b�h�|�C���g���v�Z
grid_w = linspace(w_min, w_max, nw)';

%% �c�����v���b�g���Ă݂�(�ŏI�I�Ȍ��ʂɂ͕s�v�Ȍv�Z)�F�}3

grid_a = linspace(a_min, a_max, na)';

resid1 = zeros(na, 1);
resid2 = zeros(na, 1);
resid3 = zeros(na, 1);

% w = 0.5
w = 0.5;
for i = 1:na
    resid1(i) = resid_two_period(grid_a(i));
end

% w = 0.8
w = 0.8;
for i = 1:na
    resid2(i) = resid_two_period(grid_a(i));
end

% w = 1.0
w = 1.0;
for i = 1:na
    resid3(i) = resid_two_period(grid_a(i));
end

grid_zero = zeros(na,1);

figure;
plot(grid_a, resid1, '-', 'color', 'blue', 'MarkerEdgeColor', 'b', 'MarkerSize', 12, 'linewidth', 3); hold('on');
plot(grid_a, resid2, '-.', 'color', 'green', 'MarkerEdgeColor', 'g', 'MarkerSize', 12, 'linewidth', 3);
plot(grid_a, resid3, '--', 'color', 'red', 'MarkerEdgeColor', 'r', 'MarkerSize', 12, 'linewidth', 3);
plot(grid_a, grid_zero,'-', 'color', 'black', 'linewidth', 1); hold('off');
xlabel('��N���̒��~�Fa', 'Fontsize', 16);
ylabel('�c���FR(w)', 'Fontsize', 16);
xlim([0.1, 0.5]);
ylim([-1, 1]);
legend('w=0.5', 'w=0.8', 'w=1', 'Location', 'NorthEast');
set(gca,'Fontsize', 16);
grid on;
saveas (gcf,'Fig2_resid.eps','epsc2');

%% ����`�֐��̍���T���֐���p���Ďc�����[���ɂ���a��T��

a_nl = zeros(nw,1);

for i = 1:nw
    w = grid_w(i);
    % 0.1�͏����l�F�ڍׂ�"help fzero"
    a_nl(i) = fzero(@resid_two_period, 0.01);
end

toc % �v�Z���Ԃ��J�E���g�I��

%% �}��`��

figure;
plot(grid_w, a_nl, '-o', 'color', 'blue', 'MarkerEdgeColor', 'b', 'MarkerSize', 12, 'linewidth', 3);
xlabel('��N���̏����Fw', 'Fontsize', 16);
ylabel('��N���̒��~�Fa', 'Fontsize', 16);
xlim([0, w_max]);
ylim([0, 0.5]);
set(gca, 'Fontsize', 16);
grid on;
saveas (gcf,'Fig2_fzero.eps','epsc2');

return;
