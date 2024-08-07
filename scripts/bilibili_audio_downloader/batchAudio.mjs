#!/usr/bin/env zx

process.loadEnvFile(".env"); // require node 21+

// Define an array of Bilibili video URLs
const urls = ($.env.URLS || "").split(",");

const options = [
  "--audio-only",
  "--skip-cover",
  "--skip-subtitle",
  "--hide-streams", // 不要显示所有可用音视频流
  "--work-dir", // 下载文件存放目录
  "download",
];

async function downloadLatestBBDown() {
  const currentVersion = "1.6.2";
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
    await $`curl -s ${releaseUrl} | jq '.assets[] | select(.name | contains("${targetOperateSystem}")) | .browser_download_url'`;
  const url = stdout.trim().replace(/"/g, "");
  console.log("BBDown latest url:", chalk.bgGreen.bold(url));
  const tempFileName = `temp.zip`;
  await $`curl -Lk ${url} -o ${tempFileName} && unzip -o ${tempFileName} && chmod +x BBDown && rm ${tempFileName}`;
  console.log("Download finished. ", chalk.bgGreen.bold(latestVersion));
}

async function downloadAudios() {
  urls.forEach((url, index) => {
    console.log(`[${index + 1}] Processing URL: ${chalk.bgGreen.bold(url)}`);
    $`./BBDown ${url} ${options}`;
  });
}

await downloadLatestBBDown();

await downloadAudios();
