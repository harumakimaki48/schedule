// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// Parkを選択したときにAreaを更新する処理
document.addEventListener('DOMContentLoaded', function () {
    const parkSelect = document.getElementById('park-select');
    const areaSelect = document.getElementById('area-select');
  
    // Parkセレクトボックスが存在する場合に動作
    if (parkSelect) {
      parkSelect.addEventListener('change', function () {
        const parkId = this.value; // 選択されたParkのID
  
        if (parkId) {
          // Parkに対応するAreaを取得するAPIを呼び出し
          fetch(`/areas/by_park/${parkId}`)
            .then(response => response.json())
            .then(data => {
              // Areaセレクトボックスをクリア
              areaSelect.innerHTML = '';
              // デフォルトの選択肢を追加
              const promptOption = document.createElement('option');
              promptOption.text = 'Select Area';
              promptOption.value = '';
              areaSelect.appendChild(promptOption);
  
              // 取得したAreaをセレクトボックスに追加
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
        } else {
          // Parkが選択されていない場合、Areaセレクトボックスをクリア
          areaSelect.innerHTML = '';
        }
      });
    }
  });
