// ============================================================
// Panier PRISM — logique partagée entre toutes les pages
// Stockage local (localStorage) : fonctionne sans backend.
// ============================================================
(function(window){
  var STORAGE_KEY = 'prism_cart_v1';

  function read(){
    try{
      var raw = localStorage.getItem(STORAGE_KEY);
      return raw ? JSON.parse(raw) : [];
    }catch(e){ return []; }
  }

  function write(items){
    try{ localStorage.setItem(STORAGE_KEY, JSON.stringify(items)); }catch(e){}
    updateBadges();
    try{ window.dispatchEvent(new CustomEvent('prism-cart-updated', { detail: items })); }catch(e){}
  }

  function add(item){
    var items = read();
    var existing = items.filter(function(i){
      return i.model === item.model && i.color === item.color &&
             i.storage === item.storage && i.os === item.os &&
             (i.engraving || '') === (item.engraving || '');
    })[0];
    if(existing){
      existing.qty = (existing.qty || 1) + (item.qty || 1);
    } else {
      item.id = 'item_' + Date.now() + '_' + Math.random().toString(36).slice(2, 8);
      item.qty = item.qty || 1;
      items.push(item);
    }
    write(items);
    return items;
  }

  function remove(id){
    var items = read().filter(function(i){ return i.id !== id; });
    write(items);
    return items;
  }

  function updateQty(id, qty){
    var items = read();
    for(var i = 0; i < items.length; i++){
      if(items[i].id === id){ items[i].qty = Math.max(1, qty | 0); }
    }
    write(items);
    return items;
  }

  function clear(){ write([]); }
  function getAll(){ return read(); }
  function getCount(){ return read().reduce(function(s,i){ return s + (i.qty||1); }, 0); }
  function getTotal(){ return read().reduce(function(s,i){ return s + (i.unitPrice||0) * (i.qty||1); }, 0); }

  function updateBadges(){
    var count = getCount();
    document.querySelectorAll('.cart-badge').forEach(function(el){
      el.textContent = count;
      el.style.display = count > 0 ? 'flex' : 'none';
    });
  }

  window.PrismCart = {
    add: add, remove: remove, updateQty: updateQty, clear: clear,
    getAll: getAll, getCount: getCount, getTotal: getTotal, updateBadges: updateBadges
  };

  if(document.readyState === 'loading'){
    document.addEventListener('DOMContentLoaded', updateBadges);
  } else {
    updateBadges();
  }
})(window);
