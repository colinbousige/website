_copy of https://georgecushen.com/create-your-website-with-hugo/  
(for remembering in case the link disappears)_

# Getting started with Github
Go to Github and register for an account if you have not done so already. Github encourage using your real name for your account username, and this can help your Github URL (which you will be assigned later) to look professional.

Once you have created your Github account and visited your profile, we will create two new repositories (often abbreviated as repos) on Github with the following names:

- website or any other name you like - we will save your Hugo content to this repo
- USERNAME.github.io where USERNAME is your Github username - we will save the generated HTML website to this repo

To create each repository, click the “+” icon in the top right corner and then choose “New Repository”. For the USERNAME.github.io repository, ensure to check the Initialize this repository with a README box, as this will make the next step easier. Enter a brief description if you like and then “Create repository” for each one.

In your Hugo config.toml file, set baseurl = "https://USERNAME.github.io/", where USERNAME is your Github username. Stop Hugo if it's running and delete the public directory (if it exists) with: `rm -r public/`

Install git if it's not already present on your system. You can check by running git --version.

Whilst your terminal is still in the root folder of your website, initialize a git repository and add the remote Github repository that you created:

```
git init
git remote add origin https://github.com/YOUR-USERNAME/website.git
```

Add your USERNAME.github.io repository into a submodule in a folder named public:

```
git submodule add https://github.com/YOUR-USERNAME/YOUR-USERNAME.github.io.git public
```

Add everything to your local git repository and push it up to your remote repository on GitHub:
```
git add .
git commit -m "Initial commit"
git push -u origin master
```
Whilst running the above commands you may be prompted for your Github username and password. Next, regenerate your website's HTML code by running Hugo and upload the public submodule to GitHub:
```
hugo
cd public
git add .
git commit -m "Build website"
git push -u origin master
```
Once Git has finished uploading your site to Github, you can open your new https://USERNAME.github.io website in your browser, substituting USERNAME with your Github username.
