<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div data-te-modal-init class="fixed left-0 top-0 z-[1055] hidden w-screen overflow-y-auto overflow-x-hidden" id="BuscadorModal" tabindex="-1" aria-labelledby="exampleFrameTopModalLabel" aria-hidden="true" data-te-modal-non-invasive="true">
    <div data-te-modal-dialog-ref class="relative w-full h-auto translate-y-[-50px] transition-all duration-300 ease-in-out">
        <div class="relative h-[80px] flex items-center justify-between bg-black" data-te-modal-body-ref>
            <h2 class="text-3xl px-4 text-white">Paragon</h2>
            <form action="Search.jsp" method="post" class="w-full">
                <input type="text" class="outline-none bg-stone-900 border w-full text-white focus:border-[rgb(255,100,0)] transform duration-200 h-[40px] p-2" name="keyword">
            </form>
            <button type="button" class="text-white text-2xl m-5 justify-end rotate-45 hover:scale-125 hover:hover:text-[rgb(255,100,0)] transform duration-200" data-te-modal-dismiss><i class='bx bx-cross'></i></i></button>
        </div>
    </div>
</div>