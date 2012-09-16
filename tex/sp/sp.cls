% Semantics & Pragmatics style file.
% Kai von Fintel, Christopher Potts, and Chung-chieh Shan

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{sp}[2009/07/12 v.0.6 Class for Semantics & Pragmatics]

% OUTLINE OF THIS CLASS FILE
%   option declarations 
%   required packages 
%   metadata 
%   page dimensions 
%   title 
%   running headers 
%   frontmatter 
%   sectioning 
%   footnotes 
%   bibliography 
%   backmatter 
%   other environments 
%   useful macros

%=====================================================================
%======================== option declarations ========================

\newif\if@lucida\@lucidafalse
\newif\if@cm\@cmtrue
\newif\if@times\@timestrue
\newif\if@final\@finalfalse

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\newcommand{\@sizeoption@err}{\ClassError{sp}
  {Cannot use size option \CurrentOption} 
  {The S&P style requires (and automatically loads) 12pt text}}

\DeclareOption{10pt}{\@sizeoption@err}
\DeclareOption{11pt}{\@sizeoption@err}

\DeclareOption{lucida}{\@lucidatrue \@timesfalse \@cmfalse }
\DeclareOption{times}{\@lucidafalse \@timestrue \@cmfalse }
\DeclareOption{cm}{\@lucidafalse \@timesfalse \@cmtrue}
\DeclareOption{final}{\@finaltrue}

\ExecuteOptions{times} % times is the default.
\ProcessOptions\relax
\LoadClass[12pt,twoside]{article}

\if@lucida
 \IfFileExists{lucimatx.sty}{%
    \RequirePackage[romanfamily=bright-osf, scale=0.9, stdmathdigits=true]{lucimatx}%
    \linespread{1.05}%
    \DeclareMathDelimiter{\llbracket} 
      {\mathopen}{letters}{130}{largesymbols}{130} 
    \DeclareMathDelimiter{\rrbracket} 
      {\mathclose}{letters}{131}{largesymbols}{131}
    \normalfont\DeclareTextCommand
      \textbullet\encodingdefault{\UseTextSymbol{OMS}\textbullet}
 }{\ClassWarning{sp.cls}{Requested fonts not present}}%
  \else\relax
\fi
%
\if@times
  \RequirePackage[T1]{fontenc}% use T1 font encoding
  \IfFileExists{mathptmx.sty}{\RequirePackage{mathptmx}}{}
  \IfFileExists{stmaryrd.sty}%
    {\RequirePackage{stmaryrd}}%
    {\newcommand{\llbracket}{\ensuremath{\left [\!\left [}}%
     \newcommand{\rrbracket}{\ensuremath{\right ]\!\right ]}}}
  \RequirePackage{textcomp}   
  \RequirePackage{amssymb}
  \else\relax
\fi
%
\if@cm
\IfFileExists{stmaryrd.sty}%
  {\RequirePackage{stmaryrd}}%
  {\newcommand{\llbracket}{\ensuremath{\left [\!\left [}}%
   \newcommand{\rrbracket}{\ensuremath{\right ]\!\right ]}}}
  \RequirePackage{amssymb}
  \RequirePackage{textcomp}
  \else\relax
\fi

%=====================================================================
%========================= required packages =========================

\RequirePackage[utf8]{inputenc}
\RequirePackage{xspace}
% microtype handles punctuation at the right margin. We want it for
% the final product, but it's okay if authors lack it.
\IfFileExists{microtype.sty}{%
  \RequirePackage[final,protrusion={true,compatibility}]{microtype}
}{}
\RequirePackage{ifthen}
\RequirePackage{natbib}
\RequirePackage[usenames]{color}
\definecolor{splinkcolor}{rgb}{.0,.2,.4}
\RequirePackage[colorlinks,breaklinks,
                linkcolor=splinkcolor, 
                urlcolor=splinkcolor, 
                citecolor=splinkcolor,
                filecolor=splinkcolor,
                plainpages=false,
                pdfpagelabels,
                bookmarks=false,
                pdfstartview=FitH]{hyperref}
\urlstyle{rm}
\RequirePackage[leqno,tbtags]{amsmath}
% If the author is using postscript (discouraged), then load the
% breakurl package, else don't load it.
\RequirePackage{ifpdf}
\ifpdf
  \relax
\else
  \RequirePackage{breakurl}
\fi
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage[hang,FIGBOTCAP,loose]{subfigure}
\RequirePackage{lastpage}

%=====================================================================
%============================= metadata ==============================

\def\@pdfauthor{\relax}
\newcommand{\pdfauthor}[1]{\gdef\@pdfauthor{#1}}
\def\@pdftitle{\relax}
\newcommand{\pdftitle}[1]{\gdef\@pdftitle{#1}}
\def\@pdfkeywords{\relax}
\newcommand{\pdfkeywords}[1]{\gdef\@pdfkeywords{#1}}

\hypersetup{pdfauthor=\@pdfauthor, 
            pdftitle=\@pdftitle,
            pdfkeywords=\@pdfkeywords}

\def\@spvolume{\relax}
\newcommand{\spvolume}[1]{\gdef\@spvolume{#1}}

\def\@sparticle{\relax}
\newcommand{\sparticle}[1]{\gdef\@sparticle{#1}}

\def\@spyear{\relax}
\newcommand{\spyear}[1]{\gdef\@spyear{#1}}

\def\@spdoi{10.3765/sp.\@spvolume.\@sparticle}

\def\@splastpage{\relax}
\newcommand{\splastpage}[1]{\gdef\@splastpage{#1}}
            
%=====================================================================
%========================== page dimensions ==========================

% Vertical.
\paperheight=11in
\topmargin=0in     %
\headheight=0.2in  % head: 1.5in (margin + head + sep = .5; latex adds 1in)
\headsep=0.3in     %
\topskip=0.1in     % included in the textheight
\textheight=8in    % text is 8in
\footskip=0.5in    % foot: 1.5in (.5 + 1.0in leftover)
\parskip=0pt

% Horizontal.
\paperwidth=8.5in
\textwidth=5.5in
\oddsidemargin=0.5in  % 1.5in due to LaTeX's calculations
\evensidemargin=0.5in % 1.5in due to LaTeX's calculations
\raggedbottom % constant spacing in the text; cost is a ragged bottom
\parindent=0.25in
\leftmargini=0.5in
\@ifundefined{mathindent}{}{\mathindent=0.5in\relax}%

% Tell dvips about our paper.
\special{papersize=8.5in,11in}

%=====================================================================
%============================== title ================================

% Formats individual <name--institute> pairs inside \author.
\newcommand{\spauthor}[1]%
{\begin{minipage}[t]{16pc}\centering
        #1%
 \end{minipage}\hspace{.5pc plus1pc}%
 \ignorespaces
}

\renewcommand*{\title}[2][]{\gdef\@shorttitle{#1}\gdef\@title{#2}}
\renewcommand*{\author}[2][]{\gdef\@shortauthor{#1}\gdef\@author{#2}}

% Adapted from JMLR.
\renewcommand{\maketitle}{%
  \par
  \begingroup
  \renewcommand{\thefootnote}{\fnsymbol{footnote}}
  \@maketitle\@thanks
  \setcounter{footnote}{0}
  \endgroup
  \let\maketitle\relax \let\@maketitle\relax
  \gdef\@thanks{}
  \let\thanks\relax%
}

% From salt.cls.
\newskip\onelineskip 
\onelineskip=\baselineskip 
\advance\onelineskip by0pt plus 4pt minus 2pt

\def\@maketitle{%
  \vbox{\hsize\textwidth%
    \linewidth\hsize%
    \centering
    \vskip\onelineskip
    \large\textbf{\@title}\@@par
    \normalsize
    \def\institute{\textit}%
    \newcommand{\AND}{\ignorespaces}%
    \let\par\@empty
    \@author
    \lineskiplimit\onelineskip
    \lineskip\onelineskip
    \@@par
  }%
  \global\everypar{\everypar{}\vskip 3.5ex}
}

%=====================================================================
%========================== running headers ==========================

% Creative commons license text.  The font is even smaller here than
% it is elsewhere in the headers so that we have a chance of fitting
% the whole license on the page.
\newcommand{\cctext}{{\footnotesize This is an open-access article
    distributed under the terms of a Creative Commons Non-Commercial License
    (\http{creativecommons.org/licenses/by-nc/3.0}).}}

% This boolean switch lets the user control whether the logo is
% included even when the requisite image file is present.  (If it is
% missing, then the class file accommodates that no matter how the
% switch is set.)
\newboolean{logo}
\setboolean{logo}{true} % Default true (include logo if it's present)
\newcommand{\splogo}{\setboolean{logo}{true}}
\newcommand{\nosplogo}{\setboolean{logo}{false}}

% This sets the font size for the header and footer on all pages.
\newcommand{\headerfontsize}{\footnotesize}

% Prints publication and copyright info on the first page
% Also loads info into metadata (superseded by new metadata commands)
\gdef\@articlenumber{}%
\newcommand{\firstpageheadings}[6]%
{
  \gdef\@articlenumber{#2}
  \gdef\@spvolume{#1}
  \gdef\@sparticle{#2}
  \gdef\@splastpage{#3}
  \gdef\@spyear{#4}
  \def\ps@spfirstheadings{%
    \let\@mkboth\@gobbletwo%
    \renewcommand{\@oddhead}{%
      \headerfontsize%
      % If the switch is set to "include image",
      \ifthenelse{\boolean{logo}}{%
        \ifpdf
        % If the pdf logo is present,
        \IfFileExists{sp-logo.pdf}{%
          % then insert the pdf version,
          \begin{minipage}[c]{.25in}
            \includegraphics[width=.25in]{sp-logo}
          \end{minipage}%
        }{}% else nothing; closes \IfFileExists
        \else
        % If the ps logo is present,
        \IfFileExists{sp-logo.ps}{%   
          % then insert the postscript version,
          \begin{minipage}[c]{.25in}
            \includegraphics[width=.25in]{sp-logo}
          \end{minipage}%
        }{}% else, nothing; closes \IfFileExists
        \fi % close \ifpdf
      }{}% closes \ifthenelse
      \begin{minipage}[c]{5.25in}
        \href{http://semprag.org/}{Semantics \& Pragmatics} Volume \@spvolume, Article \@sparticle: 1--\@splastpage, \@spyear\\
        doi:~\href{http://dx.doi.org/10.3765/sp.\@spvolume.\@sparticle}{10.3765/sp.\@spvolume.\@sparticle}
      \end{minipage}%
    }%
    \renewcommand{\@oddfoot}{%
      \begin{minipage}[c]{1\textwidth}%
        \footnotesize\copyright \@spyear\ \@shortauthor\\
        \cctext
      \end{minipage}%
    }%
    \renewcommand{\@evenhead}{}%
    \renewcommand{\@evenfoot}{}%
  }%
  \thispagestyle{spfirstheadings}%
}%

\newcommand{\firstpagefinalheadings}%
{
  \def\ps@spfirstheadings{%
    \let\@mkboth\@gobbletwo%
    \renewcommand{\@oddhead}{%
      \headerfontsize%
      % If the switch is set to "include image",
      \ifthenelse{\boolean{logo}}{%
        \ifpdf
        % If the pdf logo is present,
        \IfFileExists{sp-logo.pdf}{%
          % then insert the pdf version,
          \begin{minipage}[c]{.25in}
            \includegraphics[width=.25in]{sp-logo}
          \end{minipage}%
        }{}% else nothing; closes \IfFileExists
        \else
        % If the ps logo is present,
        \IfFileExists{sp-logo.ps}{%   
          % then insert the postscript version,
          \begin{minipage}[c]{.25in}
            \includegraphics[width=.25in]{sp-logo}
          \end{minipage}%
        }{}% else, nothing; closes \IfFileExists
        \fi % close \ifpdf
      }{}% closes \ifthenelse
      \begin{minipage}[c]{5.25in}
        \href{http://semprag.org/}{Semantics \& Pragmatics} Volume \@spvolume, Article \@sparticle: 1--\@splastpage, \@spyear\\
        doi:~\href{http://dx.doi.org/\@spdoi}{\@spdoi}
      \end{minipage}%
      \gdef\@articlenumber{\@sparticle}
    }%
    \renewcommand{\@oddfoot}{%
      \begin{minipage}[c]{1\textwidth}%
        \footnotesize\copyright \@spyear\ \@shortauthor\\
        \cctext
      \end{minipage}%
    }%
    \renewcommand{\@evenhead}{}%
    \renewcommand{\@evenfoot}{}%
  }%
  \thispagestyle{spfirstheadings}%
}%


% Prints abbreviated article information on non-initial pages.
\def\ps@spheadings{%
  \let\@mkboth\@gobbletwo%
  \def\@oddhead{{\headerfontsize \@shorttitle}\hfill}% short title, inner
  \def\@oddfoot{\hfill{\headerfontsize\ifx\@empty\@articlenumber\else\@articlenumber:\fi\thepage}\hfill}% centered pg no
  \def\@evenhead{\hfill{\headerfontsize\@shortauthor}}% author names, inner
  \def\@evenfoot{\hfill{\headerfontsize\ifx\@empty\@articlenumber\else\@articlenumber:\fi\thepage}\hfill}% centered pg no
}
\pagestyle{spheadings}         

%=====================================================================
%=========================== final typeset ===========================


\if@final
\RequirePackage{sp-hyperxmp}
\splogo
\AtBeginDocument{\firstpagefinalheadings}
\else            
\nosplogo
\AtBeginDocument{\thispagestyle{plain}} 
\fi


%=====================================================================
%=========================== frontmatter =============================

% The spacing specs (arg 2 of \list) are the same for the mshistory,
% abstract, and keywords environments, except that the abstract is
% indented somewhat.

% Single parameter determines the left and right margin size.
\newcommand{\frontmatterspacing}[1]{%
  \small
  \topsep 10\p@ \@plus4\p@   \@minus6\p@ % from size12.clo
  \advance\topsep by3.5ex plus -1ex minus -.2ex
  \setlength{\listparindent}{0em}
  \setlength{\itemindent}{0em}
  \setlength{\leftmargin}{#1}
  \setlength{\rightmargin}{\leftmargin}
  \setlength{\parskip}{0em}
}

\newenvironment{mshistory}%
{\list{}{\frontmatterspacing{0em}}%
\item\relax}%
{\endlist}

\renewenvironment{abstract}%
{\list{}{\frontmatterspacing{0.25in}}%
\item\relax\textbf{\abstractname} }%
{\endlist}

\newenvironment{keywords}%
{\list{}{\frontmatterspacing{0em}}%
\item\relax\textbf{Keywords:}}%
{\endlist}

%=====================================================================
%============================ sectioning =============================

\renewcommand{\section}{\@startsection{section}{1}{0pt}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\normalfont\bfseries}}

\renewcommand{\subsection}{\@startsection{subsection}{2}{0pt}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\normalfont\bfseries}}

\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{0pt}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\normalfont\bfseries}}

\renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
  {3.5ex plus 1ex minus .2ex}%
  {-1em plus0.0ex}%
  {\noindent\normalsize\bfseries}}

\renewcommand{\subparagraph}{\@startsection{subparagraph}{5}{\z@}%
  {3.5ex plus 1ex minus .2ex}%
  {-1em plus0.0ex}%
  {\noindent\normalsize\it}}

% General formatting --- for punctuating section headings.
\renewcommand{\@seccntformat}[1]{\@nameuse{the#1}\hspace{1em}}

%=====================================================================
%============================ footnotes ==============================

\renewcommand{\@makefntext}[1]{%
  \parindent=0.25in
  \noindent \hbox to \z@{\hss{\@thefnmark} \hfil}#1}

%=====================================================================
%=========================== bibliography ============================

\bibpunct[: ]{(}{)}{;}{a}{}{,}
\newcommand{\BIBand}{\&}
\providecommand{\doi}[1]{\href{http://dx.doi.org/#1}{doi:#1}}
\setlength{\bibsep}{0pt}
\setlength{\bibhang}{0.25in}
\bibliographystyle{sp}

% In text citations
\newcommand{\posscitet}[1]{\citeauthor{#1}'s (\citeyear{#1})}
\newcommand{\possciteauthor}[1]{\citeauthor{#1}'s}
\newcommand{\pgposscitet}[2]{\citeauthor{#1}'s (\citeyear{#1}:~#2)}
\newcommand{\secposscitet}[2]{\citeauthor{#1}'s (\citeyear{#1}:~$\S$#2)}
\newcommand{\pgcitealt}[2]{\citealt{#1}:~#2}
\newcommand{\seccitealt}[2]{\citealt{#1}:~$\S$#2}
\newcommand{\pgcitep}[2]{(\citealt{#1}:~#2)}
\newcommand{\seccitep}[2]{(\citealt{#1}:~$\S$#2)}
\newcommand{\pgcitet}[2]{\citeauthor{#1} (\citeyear{#1}:~#2)}
\newcommand{\seccitet}[2]{\citeauthor{#1} (\citeyear{#1}:~$\S$#2)}

%=====================================================================
%============================ backmatter =============================

% Environment for formatting all the addresses.
\newenvironment{addresses}%
{\@@par
 \let\par\@empty
 \addvspace{3.25ex}%
 \noindent%\textbf{Author addresses}
 \small
 % Individual author addresses.
 \newenvironment{address}%
   {% For email addresses inside the address environment.
    %\newcommand{\email}{\texttt}%
    \begin{minipage}[t]{16pc}\raggedright}
   {\end{minipage}\hspace{.5pc plus1pc}}%
 \ignorespaces
}%
{\lineskiplimit 1pc
 \lineskip 1pc
 \@@par}

%=====================================================================
%======================== other environments =========================

% enumerate labeling that won't conflict with standard ex. numbers.
\renewcommand{\theenumi}{\roman{enumi}}
\renewcommand{\labelenumi}{\theenumi.}
\renewcommand{\theenumii}{\alph{enumii}}
\renewcommand{\labelenumii}{\theenumii.}

% list spacing ought to satisfy \itemsep + \parsep < \topsep + \parskip
\def\@listi{\leftmargin\leftmargini
            \parsep 4\p@  \@plus2\p@ \@minus\p@
            \topsep 10\p@ \@plus4\p@ \@minus\p@
            \itemsep4\p@  \@plus2\p@ \@minus\p@}
\let\@listI\@listi
\@listi

% typeset figures with lines above and below and the caption title
% and caption texts in boxes next to each other, top aligned.
% these definitions extend those of float.sty.
\long\def\float@caption#1[#2]#3{%
  \addcontentsline{\@nameuse{ext@#1}}{#1}%
  {\protect\numberline{\@nameuse{the#1}}{\ignorespaces #2}}
  \global\setbox\@floatcapt\vbox\bgroup\@parboxrestore
  \normalsize\@fs@capt{%
    \ignorespaces\parbox[t]{0.15\textwidth}{{\@nameuse{fnum@#1}}}\ignorespaces}
  {\ignorespaces\begin{minipage}[t]{0.845\textwidth}#3\end{minipage}}%
  \@ifnextchar[{\float@ccon}{\egroup}}

\newcommand\fs@sp{\def\@fs@cfont{\bfseries}\let\@fs@capt\floatc@ruled
  \def\@fs@pre{\hrule\kern5pt}%
  \def\@fs@post{\kern5pt\hrule\relax}%
  \def\@fs@mid{\kern10pt}
  \let\@fs@iftopcapt\iffalse}

% users can override these commands using float.sty's functionality
\floatstyle{sp}
\restylefloat{figure}
\restylefloat{table}

%=====================================================================
%=========================== useful macros ===========================

\newcommand{\spj}{\emph{S\&P}\xspace}

\def\co{\colon\thinspace}

\DeclareRobustCommand\dash{%
  \unskip\nobreak\thinspace\textemdash\thinspace\ignorespaces}
\pdfstringdefDisableCommands{\renewcommand{\dash}{ - }}

% based on \url defined in hyperref.sty
\DeclareRobustCommand*{\http}{\hyper@normalise\http@}
\def\http@#1{\hyper@linkurl{\Hurl{#1}}{http://#1}}

\newcommand{\email}[1]{\href{mailto:#1}{#1}}

\providecommand{\sv}[1]{\ensuremath{\llbracket #1 \rrbracket}}

%================================ fin ================================
%=====================================================================
