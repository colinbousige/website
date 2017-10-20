\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{these}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass{report}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Declaration of needed packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[francais]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage[cyr]{aeguill}
\RequirePackage{array}
\RequirePackage{fancyhdr}
\RequirePackage[pdftex]{graphicx}\DeclareGraphicsExtensions{.jpg,.png,.pdf}
\RequirePackage[pdftex,colorlinks=false,linkcolor=blue,citecolor=blue,urlcolor=blue]{hyperref}
\RequirePackage{anysize}
\RequirePackage{color}
\RequirePackage{xcolor}
\RequirePackage[language=english,style=numeric-comp,sorting=none,backref=true,maxnames=10,minnames=6,backrefstyle=three,firstinits=true]{biblatex}
\RequirePackage{wrapfig}
\RequirePackage{amssymb,amsmath}
\RequirePackage{dsfont}
\RequirePackage{subfigure}
\RequirePackage{soul}
\RequirePackage{fourier-orns}
\RequirePackage[toc,page]{appendix}
\RequirePackage[margin=10pt,font=small,labelfont=bf,labelsep=endash,singlelinecheck=1,format=plain]{caption}
\RequirePackage[innercaption]{sidecap} \sidecaptionvpos{figure}{c}
%\RequirePackage{pdfsync}
\RequirePackage{eurosym}
\RequirePackage{esint}
\RequirePackage{multirow}\renewcommand{\multirowsetup}{\centering}
\RequirePackage{tabularx}
\RequirePackage{textcomp}
\RequirePackage{mathtools}
\RequirePackage{titlesec}
\RequirePackage{cancel}
\RequirePackage{calc}
\RequirePackage{arydshln}
\RequirePackage[francais,k-loose]{minitoc}\setcounter{minitocdepth}{4}
\mtcsettitle{minitoc}{\underline{Sommaire :\qquad\qquad\qquad\qquad\qquad\qquad\qquad\qquad\qquad\qquad\qquad\qquad\qquad\qquad\quad}}
\mtcsetrules{minitoc}{off}
\mtcsetfeature{minitoc}{before}{\vspace{-20pt}}\setlength{\mtcindent}{0pt}
%\RequirePackage{fnpct}

%\definecolor{MainRed}{rgb}{.6, .1, .2}
%\titleformat*{\section}{\bfseries\huge}


% Could never manage to get the package fnpct do what I wanted, so I used my own footnotes :
\newcommand{\ffootnote}[1]{$\!$\footnote{#1}}  % Normal footnote, starts closer to the previous letter due to negative space \!
\newcommand{\pfootnote}[1]{$\!\!$\footnote{#1}}% Footnote followed by a "," or a ".". Put the command \pfootnote AFTER the punctuation mark.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% My own bibliography style, with DOI or url links, and backreferences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand*{\mkbibnamefirst}[1]{{\iffirstinits{\let~\,}{}#1}}
\DefineBibliographyStrings{english}{%
  backrefpage = {{\emph{cf.} }}{{p.}},%
  backrefpages = {{\emph{cf.} }}{{pp.}},%
}
\DeclareFieldFormat[article]{pages}{#1}
\DeclareFieldFormat[article]{volume}{\textbf{#1}}
\ExecuteBibliographyOptions{doi=false}
\DeclareFieldFormat{doilink}{%
\iffieldundef{doi}{#1}{\href{http://dx.doi.org/\thefield{doi}}{#1}}}
\DeclareFieldFormat{urllink}{%
\iffieldundef{url}{#1}{\href{\thefield{url}}{#1}}}

\renewcommand*{\finalnamedelim}{~\emph{\&}~}
\renewcommand*{\newunitpunct}{\addcomma\space}
\renewbibmacro*{date}{\printtext{\printfield{year}}}
\renewbibmacro*{volume+number+eid}{\printfield{volume}}
\renewbibmacro*{journal+issuetitle}{%
  \emph{\usebibmacro{journal}}%
  \setunit*{\addspace}%
  \usebibmacro{volume+number+eid}
  \printtext[parens]{\printfield{year}}%
}

\DeclareBibliographyDriver{article}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/translator+others}%
  \setunit{\labelnamepunct}\newblock
  \usebibmacro{title}%
  \newunit
  \printlist{language}%
  \newunit\newblock
  \usebibmacro{byauthor}%
  \newunit\newblock
  \usebibmacro{bytranslator+others}%
  \newunit\newblock
  \printfield{version}%
  \newunit\newblock
  \iffieldundef{url}{
      \printtext[doilink]{%
      \usebibmacro{journal+issuetitle}%
      \newunit
      \usebibmacro{byeditor+others}%
      \newunit
      \usebibmacro{note+pages}}
    }%
    {\printtext[urllink]{%
      \usebibmacro{journal+issuetitle}%
      \newunit
      \usebibmacro{byeditor+others}%
      \newunit
      \usebibmacro{note+pages}}%
    }
  \newunit\newblock
  \usebibmacro{addendum+pubstate}%
  \setunit{\bibpagerefpunct}\newblock
  \usebibmacro{pageref}%
}

\DeclareBibliographyDriver{misc}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/translator+others}%
  \setunit{\labelnamepunct}\newblock
  \emph{\usebibmacro{title}}%
  \setunit{\bibpagerefpunct}\newblock
  \usebibmacro{pageref}%
}

\DeclareFieldFormat[inbook]{chapter}{"#1"}
\DeclareFieldFormat[inbook]{title}{In: \mkbibemph{#1}}
\DeclareBibliographyDriver{inbook}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/editor+others/translator+others}%
  \setunit{\labelnamepunct}\newblock
  \usebibmacro{chapter+pages}%
  \newunit\newblock
  \printtext[urllink]{\usebibmacro{maintitle+title}}%
  \newunit\newblock
  \usebibmacro{byauthor}%
  \newunit\newblock
  \usebibmacro{byeditor+others}%
  \newunit\newblock
  \usebibmacro{publisher+location+date}%
  \newunit
  \printfield{pagetotal}%
  \newunit\newblock
  \printfield{note}%
  \newunit\newblock
  \usebibmacro{addendum+pubstate}%
  \setunit{\bibpagerefpunct}\newblock
  \usebibmacro{pageref}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Page setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\addtolength{\voffset}{-.7cm}
\addtolength{\textheight}{1.4cm}

\fancypagestyle{plain}{%
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
	\lhead[]{}
	\rhead[]{}
	\fancyfoot[LE,RO]{\thepage}
}

% The style I use after. For some reason it doesn't want to be defined here,
% so I defined it in my main file :
%\pagestyle{fancyplain}
%\renewcommand{\chaptermark}[1]{\markboth{\chaptername\ \thechapter. #1}{}}
%\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
%\renewcommand{\headrulewidth}{0.5pt}
%\lhead[\bfseries\leftmark]{}
%\rhead[]{\bfseries\rightmark}
%\lfoot[\thepage]{}
%\rfoot[]{\thepage}\cfoot{}
	
\setlength\fboxrule{1pt}

\addto\captionsfrench{%
  \renewcommand{\listfigurename}{Liste des figures}%
  \renewcommand{\listtablename}{Liste des tableaux}%
  \def\tablename{{Tab.}}
  \def\figurename{{Fig.}}
}

\AtBeginDocument{\addtocontents{toc}{\protect\thispagestyle{empty}}}
\AtBeginDocument{\addtocontents{toc}{\protect\thispagestyle{plain}}}

% Chapters begin only on odd pages :
\def\cleardoublepage{\clearpage
 \if@twoside
  \ifodd\c@page\else
   \null\thispagestyle{chapterverso}\newpage
   \if@twocolumn\null\newpage\fi
   \fi
  \fi
 }%
\def\ps@chapterverso{\ps@empty}%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Equation are labeled (chapter.number_within)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\numberwithin{equation}{chapter}
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{3}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Position and police of chapter heads
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\MORETHANHUGE{\@setfontsize \MORETHANHUGE {60}{60}}
%\def\@makechapterhead#1{
%\hspace*{-.08\textwidth}
%\begin{tabular}{m{.1\textwidth}m{.9\textwidth}}
%     \MORETHANHUGE\bfseries \thechapter & \begin{center}\Huge \bfseries  #1\par\nobreak \end{center}  \\
%\end{tabular}
%}
%\makeatletter
%\newlength{\chapter@number@width}
%\def\@makechapterhead#1{%
%  {\normalfont
%  \setlength{\parindent}{0pt}%
%  \vspace*{10pt}%
%  \settowidth{\chapter@number@width}{%
%    \hbox{\color{black}\MORETHANHUGE\bfseries
%          \hspace{\dimexpr 1mm+3pt}%
%          \thechapter
%          \hspace{\dimexpr 1mm+3pt}%
%    }}
%  \hbox{%
%    \vtop{%
%      \hsize=\dimexpr\chapter@number@width+\tabcolsep+2\fboxrule+\tabcolsep
%      \begin{tabular}[t]{@{}c}
%        \scshape\strut\makebox[0pt]{\hspace{0pt plus 1 fill minus 1 fill}\hspace{0pt plus 1 fill minus 1 fill}} \\
%        \fboxsep=0pt
%        \colorbox{white}{\vbox{%
%           \hbox{\vbox to \dimexpr 1mm+3pt{}}
%           \hbox{\color{black}\MORETHANHUGE\bfseries
%                 \hspace{\dimexpr 1mm+3pt}%
%                 \thechapter
%                 \hspace{\dimexpr 1mm+3pt}%
%                }
%           \hrule height 0.4pt depth 0pt width 0pt
%           \hbox{\vbox to 6pt{}}
%           \hbox{\parbox{0pt}{\Huge\bfseries\vphantom{E}}}
%           }}%
%      \end{tabular}%
%      }%
%    \vtop{%
%      \advance\hsize by -\dimexpr\chapter@number@width+2\fboxrule+\tabcolsep
%      \hspace*{-.5cm}\begin{tabular}[t]{c}
%        \scshape\strut\vphantom{\@chapapp} \\
%        \fboxsep=0pt
%        \colorbox{white}{\vbox{%
%           \hbox{\vbox to \dimexpr 1mm+3pt{}}
%           \hbox{\LARGE\bfseries
%                 \hspace{\dimexpr 1mm+3pt}%
%                 \phantom{\thechapter}
%                 \hspace{\dimexpr 1mm+3pt}%
%                }
%           \hrule height 0.4pt depth 0pt width \hsize
%           \hbox{\vbox to 6pt{}}
%           \hbox{\hspace*{20pt}\parbox{\dimexpr\textwidth-2mm-6pt-\chapter@number@width-\tabcolsep-2\fboxrule-20pt}{\Huge\bfseries #1}}
%           }}%
%      \end{tabular}%
%      }%
%    }%
%  \vspace{50pt}%
%  }
%}
%\def\@makeschapterhead#1{%
%  {\normalfont
%  \setlength{\parindent}{0pt}%
%  \vspace*{10pt}%
%  \settowidth{\chapter@number@width}{%
%    \hbox{\color{white}\LARGE\bfseries
%          \hspace{\dimexpr 1mm+3pt}%
%          \thechapter
%          \hspace{\dimexpr 1mm+3pt}%
%    }}
%  \hbox{%
%    \vtop{%
%      \hsize=\dimexpr\chapter@number@width+\tabcolsep+2\fboxrule+\tabcolsep
%      \begin{tabular}[t]{@{}c}
%        \scshape\strut\makebox[0pt]{\hspace{0pt plus 1 fill minus 1 fill}\phantom{\@chapapp}\hspace{0pt plus 1 fill minus 1 fill}} \\
%        \fboxsep=0pt
%        \colorbox{black}{\vbox{%
%           \hbox{\vbox to \dimexpr 1mm+3pt{}}
%           \hbox{\color{white}\LARGE\bfseries
%                 \hspace{\dimexpr 1mm+3pt}%
%                 \phantom{\thechapter}%
%                 \hspace{\dimexpr 1mm+3pt}%
%                }
%           \hrule height 0.4pt depth 0pt width 0pt
%           \hbox{\vbox to 6pt{}}
%           \hbox{\parbox{0pt}{\Huge\bfseries\vphantom{E}}}
%           }}%
%      \end{tabular}%
%      }%
%    \vtop{%
%      \advance\hsize by -\dimexpr\chapter@number@width+2\fboxrule+\tabcolsep
%      \hspace*{-0.5cm}\begin{tabular}[t]{c}
%        \scshape\strut\vphantom{\@chapapp} \\
%        \fboxsep=0pt
%        \colorbox{white}{\vbox{%
%           \hbox{\vbox to \dimexpr 1mm+3pt{}}
%           \hbox{\LARGE\bfseries
%                 \hspace{\dimexpr 1mm+3pt}%
%                 \phantom{\thechapter}
%                 \hspace{\dimexpr 1mm+3pt}%
%                }
%           \hrule height 0.4pt depth 0pt width \hsize
%           \hbox{\vbox to 6pt{}}
%           \hbox{\hspace*{20pt}\parbox{\dimexpr\textwidth-2mm-6pt-\chapter@number@width-\tabcolsep-2\fboxrule-20pt}{\Huge\bfseries #1}}
%           }}%
%      \end{tabular}%
%      }%
%    }%
%  \vspace{50pt}%
%  }
%}
%\makeatother



\def\@makechapterhead#1{%
  \vspace*{-20\p@}%
  {\parindent \z@  \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \MORETHANHUGE\bfseries \centering \thechapter
        \par\nobreak
        \vskip 20\p@
    \fi
    \interlinepenalty\@M
    \normalfont \centering \Huge \bfseries #1\par\nobreak
    \vskip 40\p@
  }}
\def\@makeschapterhead#1{
  \vspace*{-20\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \Huge \bfseries  #1\par\nobreak
    \vskip 20\p@
  }
 }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creation of subsubsubsection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
\renewcommand\paragraph{\@startsection{paragraph}{4}{0pt}%
                                      {-3.25ex plus -1ex minus -.2ex}%
                                      {1.5ex plus .2ex}%
                                      {\normalfont\normalsize\bfseries}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{11.1em}{5em}}
\makeatother
\let\subsubsubsection\paragraph
\renewcommand{\theparagraph}{\thesubsubsection.\alph{paragraph}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Macro for changing margin locally
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{changemargin}[2]{\begin{list}{}{%
\setlength{\topsep}{0pt}%
\setlength{\leftmargin}{0pt}%
\setlength{\rightmargin}{0pt}%
\setlength{\listparindent}{\parindent}%
\setlength{\itemindent}{\parindent}%
\setlength{\parsep}{0pt plus 1pt}%
\addtolength{\leftmargin}{#1}%
\addtolength{\rightmargin}{#2}%
}\item }{\end{list}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abbreviations I often use
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand\mathbf\boldsymbol
\newcommand{\lrp}[1]{\left(#1\right)}
\newcommand{\lrc}[1]{\left[#1\right]}
\newcommand{\lra}[1]{\left\{#1\right\}}
\newcommand{\lrm}[1]{\left|#1\right|}
\newcommand{\lrang}[1]{\left<#1\right>}
\newcommand{\ie}{\emph{i.e.}}
\newcommand{\degC}{\,$^\circ$C}
\renewcommand{\deg}{\,$^\circ$}
\newcommand{\Aa}{\AA$^{-1}$}
\newcommand{\sinc}[1]{\text{sinc}\left(#1\right)}
\newcommand{\acos}[1]{\text{acos}\left(#1\right)}
\newcommand{\asin}[1]{\text{asin}\left(#1\right)}
\newcommand{\atan}[1]{\text{atan}\left(#1\right)}
\newcommand{\sincc}[1]{\text{sinc}^2\left(#1\right)}
\newcommand{\C}[1]{C$_{#1}$}
\newcommand{\cs}{C$_{60}$}
\newcommand{\csd}{C$_{70}$}
\newcommand{\hgasf}{Hg$_{3-\delta}$AsF$_6$}
\newcommand{\sqw}{$S(Q,\omega)$}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput
