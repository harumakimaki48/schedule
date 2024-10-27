// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// Parkを選択したときにAreaを更新する処理
document.addEventListener('turbo:load', function () {
    const parkSelect = document.getElementById('park-select');
    const areaSelect = document.getElementById('area-select');
    const landBtn = document.getElementById('land-btn');
    const seaBtn = document.getElementById('sea-btn');
    const shopSelects = document.querySelectorAll('[id^="shop-select"]'); // IDが'shop-select'で始まる全ての要素を取得

    // Parkセレクトボックスが存在する場合に動作
    if (parkSelect) {
        parkSelect.addEventListener('change', function () {
            const parkId = this.value;
            if (parkId) {
                fetchAreas(parkId);
            }
        });
    }

    // LANDボタンが押されたときの処理
    if (landBtn) {
        landBtn.addEventListener('click', function () {
            fetchShopsByPark(1);
        });
    }

    // SEAボタンが押されたときの処理
    if (seaBtn) {
        seaBtn.addEventListener('click', function () {
            fetchShopsByPark(2);
        });
    }

    // Area取得用の関数
    function fetchAreas(parkId) {
        fetch(`/areas/by_park/${parkId}`)
            .then(response => response.json())
            .then(data => {
                areaSelect.innerHTML = '';
                const promptOption = document.createElement('option');
                promptOption.text = 'Select Area';
                promptOption.value = '';
                areaSelect.appendChild(promptOption);

                data.forEach(area => {
                    const option = document.createElement('option');
                    option.value = area.id;
                    option.text = area.area_name;
                    areaSelect.appendChild(option);
                });
            })
            .catch(error => {
                console.error('Error fetching areas:', error);
            });
    }

    // Shop取得用の関数（複数のドロップダウンリストを更新）
    function fetchShopsByPark(parkId) {
        fetch(`/shops?park_id=${parkId}`)
            .then(response => response.json())
            .then(data => {
                shopSelects.forEach(shopSelect => {
                    shopSelect.innerHTML = '';  // 各ドロップダウンをクリア
                    const promptOption = document.createElement('option');
                    promptOption.text = 'Select Shop';
                    promptOption.value = '';
                    shopSelect.appendChild(promptOption);

                    data.forEach(shop => {
                        const option = document.createElement('option');
                        option.value = shop.id;
                        option.text = shop.shop_name;
                        shopSelect.appendChild(option);
                    });
                });
            })
            .catch(error => {
                console.error('Error fetching shops:', error);
            });
    }
});
