const API_ENDPOINT = 'https://qdthgyamj3.execute-api.ap-south-1.amazonaws.com/prod/visitor-count';

// Function to update the visitor count
async function updateVisitorCount() {
    try {
        console.log('Fetching visitor count...');
        const response = await fetch(API_ENDPOINT, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        
        console.log('Response status:', response.status);
        const responseText = await response.text();
        console.log('Response text:', responseText);
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const responseData = JSON.parse(responseText);
        console.log('Response data:', responseData);
        
        // Parse the body if it's a string (Lambda Proxy response)
        const data = responseData.body ? JSON.parse(responseData.body) : responseData;
        console.log('Final data:', data);
        
        if (data.count !== undefined) {
            document.getElementById('visitor-count').textContent = data.count;
        } else {
            console.error('No count in response:', data);
            document.getElementById('visitor-count').textContent = 'Error: No count';
        }
    } catch (error) {
        console.error('Error updating visitor count:', error);
        document.getElementById('visitor-count').textContent = 'Error loading count';
    }
}

// Update the count when the page loads
document.addEventListener('DOMContentLoaded', updateVisitorCount);