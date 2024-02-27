import requests
import pandas as pd
from bs4 import BeautifulSoup
from datetime import datetime, timedelta
# Function to extract details from a video link
def get_video_details(video_url):
    res_video = requests.get(video_url)
    res_video.encoding = 'utf-8'
    soup_video = BeautifulSoup(res_video.text, 'html.parser')
    title = soup_video.find('title').text
    description = soup_video.find('meta', {'name': 'description'})['content']
    source = soup_video.find('span', class_='laiyuan').text
    time = soup_video.find('span', class_='time').text
    content = soup_video.find('div', id='content_area').text.strip()
    return f"标题: {title}\n描述: {description}\n来源: {source}\n时间: {time}\n内容: {content}"

COLUMNS = ['Video Title', 'Video Link', 'Video Image', 'Video Duration']
# Initialize DataFrame
df = pd.DataFrame(columns=COLUMNS)
# Specify the date range
start_date = datetime.strptime('20240129', '%Y%m%d')
end_date = datetime.today()

# Iterate over each day in the date range
while start_date <= end_date:
    date_str = start_date.strftime('%Y%m%d')
    url = f'https://tv.cctv.com/lm/xwlb/day/{date_str}.shtml'
    print(url)
    # Fetch HTML content
    res = requests.get(url)
    res.encoding = 'utf-8'
    html_code = res.text
    soup = BeautifulSoup(html_code, 'html.parser')

    # Extract information from each video entry
    for li in soup.find_all('li'):
        a_tag = li.find('a', {'alt': True})
        if a_tag:
            video_title = a_tag.get('alt')
            video_link = li.find('a', {'href': True}).get('href')
            video_image = li.find('img').get('src')
            video_duration = li.find('span').text

            df = df._append({'Video Title': video_title,
                            'Video Link': video_link,
                            'Video Image': video_image,
                            'Video Duration': video_duration}, ignore_index=True)
    # Print or use the DataFrame as needed
    df['Details'] = df['Video Link'].apply(get_video_details)
    # Save DataFrame to CSV
    df.to_csv(f'videos_{date_str}.csv', index=False)
    # Clear the DataFrame for the next iteration
    df = pd.DataFrame(columns=COLUMNS)
    start_date += timedelta(days=1)