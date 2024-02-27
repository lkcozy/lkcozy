#!/usr/bin/env zx

// Define an array of Bilibili video URLs
const urls = []; // ["url1","url2"]

const options = [
  "--audio-only",
  "--skip-cover",
  "--skip-subtitle",
  "--hide-streams",
  "--work-dir",
  "download",
];

async function downloadLatestBBDown() {
  const currentVersion = "1.6.1";
  const targetOperateSystem = "osx-x64";
  const releaseUrl =
    "https://api.github.com/repos/nilaoda/BBDown/releases/latest";

  const result = await $`curl -s ${releaseUrl} | jq -r '.tag_name'`;
  const latestVersion = result.stdout.trim();
  if (currentVersion === latestVersion) return;

  console.log(
    "Found new version of BBDown: ",
    chalk.bgGreen.bold(latestVersion)
  );

  const { stdout } =
    await $`curl -s ${releaseUrl} | jq '.assets[] | select(.name | contains(${targetOperateSystem})) | .browser_download_url'`;
  const url = stdout.trim().replace(/"/g, "");
  console.log("BBDown latest url:", chalk.bgGreen.bold(url));
  $`curl -Lk ${url} -o temp.zip && unzip -o temp.zip && chmod +x BBDown && rm temp.zip`;
}

async function downloadAudios() {
  urls.forEach((url, index) => {
    console.log(`[${index + 1}] Processing URL: ${chalk.bgGreen.bold(url)}`);
    $`./BBDown ${url} ${options}`;
  });
}

await downloadLatestBBDown();
await downloadAudios();
