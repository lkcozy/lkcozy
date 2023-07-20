#!/usr/bin/env zx

// Define an array of Bilibili video URLs
const urls = [];

const options = ["--audio-only", "--skip-cover"];

// Loop through each URL in the array and download the video using BBDown
urls.forEach((url) => {
  console.log(`Processing URL: ${chalk.bgGreen.bold(url)}`);
  $`./BBDown  ${options} ${url}`;
});
