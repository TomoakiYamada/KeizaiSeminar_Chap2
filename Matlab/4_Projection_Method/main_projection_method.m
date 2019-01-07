%% ���C���t�@�C��:
% �ˉe�@��p����2���ԃ��f��������.
% ���ӁFMatlab�֐�"fsolve"���g���Ă��邽�߁A���ɂ���Ă͓����Ȃ��\��������܂�.

clear;
clear global;
close all;
format long;

% �O���[�o���ϐ��Fapprox_policy.m�Aresid_projection.m�ƕϐ������L
global dim_app nw grid_w beta gamma rent

%% *** �J���u���[�V���� ***
beta  = 0.985.^30;     % �������q
gamma = 2.0;           % ���ΓI�댯���x
rent  = 1.025.^30-1.0; % �����q��
%======================================

% *** �p�����[�^ ***
nw    =  10;  % �����O���b�h�̐�
w_max = 1.0;  % �����O���b�h�̍ő�l
w_min = 0.1;  % �����O���b�h�̍ŏ��l
%===========================

%% �ˉe�@��2���ԃ��f��������

tic % �v�Z���Ԃ��J�E���g�J�n

disp(' ');
disp('-+-+-+- Solve two period model using projection method -+-+-+-');

% �I�_(collocation)�����߂�
grid_w = linspace(w_min, w_max, nw)';

% �������̎���������
dim_app = 1;

% �W���̏����l�𓖂Đ���(initial guess)
coef_ini = [0.1, 0.35];

% debug
%next_a = approx_policy(coef, grid_a1);

% debug
%resid = resid_projection(coef_ini);

% fsolve�̐ݒ�F(i)���[�x���o�[�O�E�}���J�[�g�@���g���A(ii)�����̍ő�񐔂�1000��ɐݒ�
options = optimoptions('fsolve', 'Algorithm', 'levenberg-marquardt', 'MaxFunctionEvaluations', 1000);

% fsolve���g���āA�I�_��Ŏc�����[���ɋ߂��Ȃ�W��theta��T��
% ���ӁFStudent edition�ł�fsolve�������Ă��Ȃ������m��܂���.
coef = fsolve(@resid_projection, coef_ini, options);

disp(' ');
disp('approximated psi0');
disp(coef(1));
disp('approximated psi1');
disp(coef(2));

toc % �v�Z���Ԃ��J�E���g�I��

%% ��͓I��

coef1 = (beta*(1+rent))^(-1/gamma);
coef2 = 1.0/(1.0+coef1*(1+rent));

icept = 0.0;
slope = coef2;

disp(' ');
disp('true psi0');
disp(icept);
disp('true psi1');
disp(slope);

%% �}��`��

% fsolve���g���ē���"coef"���g���Đ���֐����v�Z
next_a = approx_policy(coef, grid_w);

figure;
plot(grid_w,next_a,'-o','color','blue','MarkerEdgeColor','b','MarkerSize',12,'linewidth',3);
xlabel('��N���̏���','Fontsize',16);
ylabel('��N���̒��~','Fontsize',16);
xlim([0,w_max]);
ylim([0,0.5]);
set(gca,'Fontsize',16);
grid on;
saveas (gcf,'Fig2_projection.eps','epsc2');

return;
