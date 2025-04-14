% dutletter_en.cls -- A document class for writing letters with DUT letterhead
%                    带有大连理工大学信头的信件类
%
% This class is based on the standard LaTeX 'letter.cls' and customized
% to include the DUT logo and address in the header and footer.
% 此类基于标准的 LaTeX 'letter.cls'，并定制了页眉和页脚以包含大连理工大学的标志和地址。
%
% Author: Frankie
%
%
% Notes:
% 注意：
%
% 1. This class can be used to create letters with the DUT logo in the header
%    and the department address in the footer.
%    此类可用于在页眉包含大连理工大学标志、页脚包含学院地址的信件。
%
% 2. It is based on the standard LaTeX document class 'letter.cls'.
%    它基于标准的 LaTeX 文档类 'letter.cls'。
%
% 3. The logo file 'DUT.png' must be provided; otherwise, the logo is omitted.
%    必须提供标志文件 'DUT.png'；否则，将省略标志。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MIT License

% Copyright (c) [2025] Frankie

% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:

% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.

% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dutletter_en}[2025/04/13 v2.0 DUT letter class (English version)]

% Required packages
% 必需的宏包
\RequirePackage{graphicx}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\RequirePackage{varwidth}

% Define DUT standard color
% 定义大连理工大学的标准颜色
\definecolor{dutcolor}{RGB}{2,115,188}

% Set graphics extensions
% 设置图形文件扩展名
\DeclareGraphicsExtensions{.pdf,.png,.jpg}

% Pass options to the base 'letter' class
% 将选项传递给基础的 'letter' 类
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions\relax
\LoadClass[letterpaper]{letter}

% Define subject commands
% 定义主题命令
\newcommand{\subjectname}{Subject}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}

% Check if the logo file exists
% 检查标志文件是否存在
\newboolean{logofound}
\IfFileExists{figs/DUT.png}
    {\setboolean{logofound}{true}}
    {\setboolean{logofound}{false}}

% Page layout settings
% 页面布局设置
\setlength{\textwidth}{6.5in}
\setlength{\textheight}{9in}
\setlength{\oddsidemargin}{0in}
\setlength{\topmargin}{-0.75in}

% Define fonts
% 定义字体
\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{12}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{12}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{10}

% Define header and footer
% 定义页眉和页脚
\newsavebox{\universityhead}
\newsavebox{\universityfoot}

% Header with DUT logo
% 带有大连理工大学标志的页眉
\sbox{\universityhead}{%
    \begin{tabular*}{\textwidth}{@{}l@{}}
        \ifthenelse{\boolean{logofound}}
            {\includegraphics[height=1in]{figs/DUT.png}}
            {\ClassWarning{dutletter_en}{DUT.png not found!}}
    \end{tabular*}%
}

% Footer with university address
% 带有大学地址的页脚
% \sbox{\universityfoot}{\ixcmrmn
%     \begin{tabular}{l}
%         Dalian University of Technology\\
%         Address: No.2 Linggong Road, Ganjingzi District, Dalian, Liaoning, China\\
%         Zip Code: 116024
%     \end{tabular}
% }

% Redefine page styles
% 重新定义页面样式
\renewcommand{\ps@firstpage}{%
    \setlength{\headheight}{1in}
    \setlength{\headsep}{0.2in}
    \renewcommand{\@oddhead}{\usebox{\universityhead}}
    \renewcommand{\@oddfoot}{\usebox{\universityfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{\usebox{\universityfoot}}
}

\renewcommand{\ps@empty}{%
    \setlength{\headheight}{1in}
    \setlength{\headsep}{0.2in}
    \renewcommand{\@oddhead}{}
    \renewcommand{\@oddfoot}{\usebox{\universityfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{\usebox{\universityfoot}}
}

\pagestyle{empty}

% Redefine opening command
% 重新定义开头命令
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
    \ifx\@empty\fromaddress
        % No from address provided
        % 未提供发信人地址
    \else
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\*[1\parskip]
            \@date
            \end{tabular}\par
        }%
    \fi
    \vspace{2\parskip}
    {\raggedright \toname \\ \toaddress \par}%
    \vspace{1\parskip}%
    \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
    \vspace{1\parskip}%
    #1\par\nobreak
}

% Redefine closing command
% 重新定义结尾命令
\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
    \stopbreaks
    \noindent
    \hfill\begin{varwidth}{\textwidth}\raggedright
    \ignorespaces #1\\[2\medskipamount]%
    \ifx\@empty\fromsig
        \fromname
    \else \fromsig
    \fi\strut\end{varwidth}%
    \par
}
% 暂时废弃
% 导入必要的包
% \RequirePackage{tikz} % 用于透明度和图形处理
% \RequirePackage{eso-pic} % 用于在页面背景上添加内容

% 定义水印的命令
% \newcommand{\applywatermark}{
%   \AddToShipoutPictureBG{
%     \AtPageCenter{
%       \begin{tikzpicture}
%         \node[opacity=0.3] {\includegraphics[width=0.5\paperwidth]{logo.pdf}}; % 使用 tikz 处理透明度
%       \end{tikzpicture}
%     }
%   }
% }

% % 在每一页添加水印
% \AtBeginDocument{\applywatermark}
% \newcommand{\watermark}[2]{\AddToShipoutPictureBG{
% \parbox[b][\paperheight]{\paperwidth}{
% \vfill%
% \centering%
% \begin{tikzpicture}
%     \path (0,0) -- (\paperwidth,\paperheight);
%     \node[opacity=#2] at (current page.center)
%     {\includegraphics[width=0.5\textwidth]{figs/#1}};
% \end{tikzpicture}
% \vfill}}}
\newcommand{\watermark}[2][logo.pdf]{%
    \def\wmopacity{0.5}% 默认透明度
    \IfValueT{#2}{\def\wmopacity{#2}}% 如果提供了第二个参数
    
    \AddToShipoutPictureBG{%
        \parbox[b][\paperheight]{\paperwidth}{%
            \vfill%
            \centering%
            \begin{tikzpicture}%
                \path (0,0) -- (\paperwidth,\paperheight);%
                \node[opacity=\wmopacity] at (current page.center)%
                {\includegraphics[width=0.5\textwidth]{figs/#1}};%
            \end{tikzpicture}%
            \vfill%
        }%
    }%
}
